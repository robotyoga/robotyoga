# me - this DAT
# scriptOp - the OP which is cooking
#
# press 'Setup Parameters' in the OP to call this function to re-create the parameters.
def setupParameters(scriptOp):
	page = scriptOp.appendCustomPage('Custom')
	p = page.appendFloat('Valuea', label='Value A')
	p = page.appendFloat('Valueb', label='Value B')
	return

# called whenever custom pulse parameter is pushed
def onPulse(par):
	return

import math
import cv2
import numpy as np

def cook(scriptOp):
	scriptOp.clear()
	objp = scriptOp.inputs[0]
	imgp = scriptOp.inputs[1]

	if objp.numRows > 5 and imgp.numRows > 5:
		geoPoints = [(float(objp[x+1,'tx'].val),float(objp[x+1,'ty'].val),float(objp[x+1,'tz'].val)) for x in range(objp.numRows-1)]
		imgPoints = [(float(imgp[x+1,'x'].val),float(imgp[x+1,'y'].val)) for x in range(imgp.numRows-1)]

		# get image size
		pWidth = parent().par.w
		pHeight = parent().par.h

		# get fov
		fov = parent.camSchnappr.par.Fov.eval()

		# near and far
		near = parent.camSchnappr.par.Near.eval()
		far = parent.camSchnappr.par.Far.eval()

		# get flags
		intrinsic = parent.camSchnappr.par.Intrinsic.eval()
		fixaspect = parent.camSchnappr.par.Aspect.eval()
		zeroTangent = parent.camSchnappr.par.Tangent.eval()
		fixPrincipal = parent.camSchnappr.par.Principal.eval()
		fixK1 = parent.camSchnappr.par.Fixk1.eval()
		fixK2 = parent.camSchnappr.par.Fixk2.eval()
		fixK3 = parent.camSchnappr.par.Fixk3.eval()

		# get criteria params
		maxIter = parent.camSchnappr.par.Maxiterations.eval()
		precision = parent.camSchnappr.par.Precision.eval()

		#############################################
		# do with cv2.calibrateCamera
		#############################################

		# build input for calibrateCamera
		size = (pWidth, pHeight)
		cvGeoPoints = np.array([geoPoints], np.float32)
		cvImgPoints = np.array([imgPoints], np.float32)

		# set camera matrix
		f = pWidth * (fov / 180 * 3.14)
		camMtx = [[f, 0, pWidth / 2], [0, f, pHeight / 2], [0, 0, 1]]
		camMtx = np.matrix(camMtx, np.float32)

		# set empty distortion vector
		dist = np.zeros((5,), np.float32)

		# set flags
		flags = 0
		if intrinsic:
			flags += cv2.CALIB_USE_INTRINSIC_GUESS
		if fixaspect:
			flags += cv2.CALIB_FIX_ASPECT_RATIO
		if zeroTangent:
			flags += cv2.CALIB_ZERO_TANGENT_DIST
		if fixPrincipal:
			flags += cv2.CALIB_FIX_PRINCIPAL_POINT
		if fixK1:
			flags += cv2.CALIB_FIX_K1
		if fixK2:
			flags += cv2.CALIB_FIX_K2
		if fixK3:
			flags += cv2.CALIB_FIX_K3

		# termination criteria
		criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, maxIter, precision)

		# run calibration
		ret, mtx, dist, rvecs, tvecs = cv2.calibrateCamera(cvGeoPoints,cvImgPoints,size,camMtx,dist,None,None,flags=flags,criteria=criteria)

		# get rotation matrix
		rot, jacob = cv2.Rodrigues(rvecs[0],None)

		# fill rotation table
		cvRotate = op('cvRotate')
		for i,v in enumerate(rot):
			for j,rV in enumerate(v):
				cvRotate[i,j] = rV

		# fill translate vector
		cvTranslate = op('cvTranslate')
		for i,v in enumerate(tvecs[0]):
			cvTranslate[0,i] = v[0]

		# break appart camera matrix
		fovx, fovy, focalLength, principalPoint, aspectRatio = cv2.calibrationMatrixValues(mtx,size,pWidth,pHeight)

		# fill values table
		cvValues = op('cvValues')
		cvValues['focalX',1] = focalLength
		cvValues['focalY',1] = focalLength
		cvValues['principalX',1] = principalPoint[0]
		cvValues['principalY',1] = principalPoint[1]
		cvValues['width',1] = pWidth
		cvValues['height',1] = pHeight

		l = near * (-principalPoint[0]) / focalLength
		r = near * (pWidth - principalPoint[0]) / focalLength
		b = near * (principalPoint[1] - pHeight) / focalLength
		t = near * (principalPoint[1]) / focalLength

		A = (r + l) / (r - l)
		B = (t + b) / (t - b)
		C = (far + near) / (near - far)
		D = (2 * far * near) / (near - far)

		nrl = (2 * near) / (r - l)
		ntb = (2 * near) / (t - b)

		projMat = tdu.Matrix([nrl,0,0,0],[0,ntb,0,0],[A,B,C,-1],[0,0,D,0])
		scriptOp.appendRow(projMat) 


		# transform Matrix
		transMat = tdu.Matrix([rot[0][0],rot[0][1],rot[0][2],tvecs[0][0]],[-rot[1][0],-rot[1][1],-rot[1][2],-tvecs[0][1]],[-rot[2][0],-rot[2][1],-rot[2][2],-tvecs[0][2]],[0,0,0,1])
		scriptOp.appendRow(transMat)
	return

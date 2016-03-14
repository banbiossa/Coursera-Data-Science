names = ['roll_belt','skewness_roll_belt','min_yaw_belt','gyros_belt_x','total_accel_arm','gyros_arm_x','skewness_yaw_arm','roll_dumbell','skewness_pitch_dumbell']
for i in xrange(1,len(names)-1):
	print 'which(colnames(training) == "%s")' % (names[i])

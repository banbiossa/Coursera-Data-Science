names = ['roll_belt','yaw_belt','gyros_belt_x','yaw_arm','gyros_arm_x','magnet_arm_z','gyros_belt_x','magnet_belt_z','gyros_arm_x','magnet_arm_z','classe']
for i in xrange(0,len(names)):
	print 'which(colnames(training) == "%s")' % (names[i])

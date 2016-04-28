'use strict';

suite 'generate', ->
	set 'iterations', 1
	set 'concurrency', 1
	set 'type', 'static'

	run = require '../generate.js'
	runSync = require '../generateSync.js'

	bench 'async generate test', ->
		run 'http://www.baidu.com', 'head.jpg', 'state.png'

	bench 'sync generate test', ->
		runSync 'http://www.baidu.com', 'head.jpg', 'state.png'
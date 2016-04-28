Canvas = require 'canvas'
fs = require 'fs'
qr = require 'qr-js'

module.exports = (qrContent, headFile, destFile)->
	# start = new Date().getTime()
	# console.log 'sync start is ' + start
	buf = fs.readFileSync __dirname + '/bk.jpg'
	img = new Canvas.Image
	img.src = buf
	canvas = new Canvas img.width, img.height
	ctx = canvas.getContext '2d'

	# draw background
	ctx.drawImage img, 0, 0

	# get qrcode image
	img1 = qr.image qrContent

	# draw qrcode
	ctx.drawImage img1, 150, 400

	ctx.save()

	ctx.beginPath()
	ctx.arc 200, 145, 50, 0, 2 * Math.PI
	ctx.fillStyle = '#e4c5a8'
	ctx.fill()
	ctx.closePath()

	ctx.restore()

	buf1 = fs.readFileSync __dirname + '/' + headFile

	# get head photo
	img2 = new Canvas.Image
	img2.src = buf1
	
	ctx.save()

	# circle clip()
	ctx.beginPath()
	ctx.arc 200, 145, 45, 0, 2 * Math.PI
	ctx.clip()

	# draw head
	ctx.drawImage img2, 155, 100, 90, 90
	ctx.restore()

	# output
	out = fs.createWriteStream __dirname + '/' + destFile
	stream = canvas.pngStream()
	stream.on 'data', (chunk) ->
		out.write chunk
	stream.on 'error', (err) ->
		throw err
	stream.on 'end', ->
		# end = new Date().getTime()
		# console.log 'end is ' + end
		# return console.log 'diff is ' + (end - start)

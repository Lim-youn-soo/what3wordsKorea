var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var clients = [];
var multer = require('multer');
var storage = multer.diskStorage({
	destination: function(req, file, cb){
		cb(null, 'uploads/');
	},
	filename: function(req, file, cb){
		cb(null, file.fieldname + '-' + Date.now() + '.jpg');
	}
});
var upload = multer({ 
	dest: 'uploads/',
	storage : storage
});

app.post('/uploadprof', upload.single('file1'), function(req, res, next){
	console.log(req.file);
})


http.listen(1337,function(){
    console.log('Server Start at *:1337');
});

io.on('connection', function(socket){
	console.log('socket detected');
	// 1대1 채팅을 위해 세션 정보 저장
	socket.on('session', function(id){
		console.log(socket.id + ' Session connected');
		var Client = new Object();
		Client.uid = id;
		Client.sid = socket.id;
		clients.push(Client);
	});

	// 1 대 1 채팅
	socket.on('individual', function(data){
		console.log('Chat Sent to ' + data[0]);
		for (var i=0; i<clients.length; i++){
			if (clients[i].uid == data[0]){
				io.to(clients[i].sid).emit('individual', data);
				return false;
			}
		}
		io.to(socket.id).emit('end', null);
	});

	// 지역 별 채팅방 접속
	socket.on('joinRoom', function(data){
		socket.join(data);
	});

	// 지역 별 채팅방 메세지 전송
	socket.on('statechat', function(data){
		socket.broadcast.to(data[0]).emit('statechat', data);
	});

	// 대화 끝낼 시 해당 세션의 소켓 ID로 클라이언트 배열에서 삭제
	socket.on('disconnect', function(){
		for (var i=0; i<clients.length; i++){
			if (clients[i].sid = socket.id){
				console.log(clients[i].uid + ' disconnected');
				clients.splice(i, 1);
				break;
			}
		}
	});
});
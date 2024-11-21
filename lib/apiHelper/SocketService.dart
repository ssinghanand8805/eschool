
// import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'dart:async';

import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class EchoService {
  late Echo echo;
  late IO.Socket socket;
  void initialize(String token) {
    print("SocketService::${token}");
     socket = IO.io(
      'http://13.234.137.77:6001',
      IO.OptionBuilder()
          .setTransports(['websocket']) // Try with ['polling', 'websocket'] if still failing
          .disableAutoConnect()
          .setExtraHeaders({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      })
          .setTimeout(20000)           // Increase timeout to 20 seconds
          .setReconnectionAttempts(5)
          .setReconnectionDelay(3000)
          .enableForceNewConnection()
          .setQuery({                  // Add query parameters for debugging
        'token': token,
        'EIO': '4',               // Engine.IO version
        'transport': 'websocket'
      }).build(),
    );
// socket.connect();

// Create echo instance
    try
    {
      echo = new Echo(
        broadcaster: EchoBroadcasterType.SocketIO,
        client: socket,
        options: {
          'auth': {
            'headers': {
              'Authorization': 'Bearer $token',
            }
          },
        },
      );
      // socket.connect();
      print(socket.connected);

      _setupDebugListeners();

      // Connect and verify connection
      socket.connect();
      _verifyConnection();
    }
    catch(e) {
      print("eeeeeeeee");
    print(e);

    }

    // echo.connector.socket.onConnect((_) => print('connected'));
    // echo.connector.socket.onDisconnect((_) => print('disconnected'));
  }
  Future<void> _verifyConnection() async {
    int attempts = 0;
    const maxAttempts = 5;

    while (attempts < maxAttempts && !socket.connected) {
      print('🔄 Connection attempt ${attempts + 1}/$maxAttempts');
      await Future.delayed(Duration(seconds: 1));
      attempts++;
    }

    if (!socket.connected) {
      print('❌ Failed to connect after $maxAttempts attempts');
    }
  }
  void _setupDebugListeners() {
    socket.onConnect((_) {
      print('✅ Socket Connected with ID: ${socket.id}');
      // print('✅ Socket Options: ${socket.options}');
      // print('✅ Socket Auth: ${socket.auth}');
    });

    socket.onConnectError((data) {
      print('❌ Connect Error: $data');
      print('Current Socket State: ${socket.connected}');
      // print('Socket Options: ${socket.options}');
    });

    socket.onError((error) {
      print('❌ Socket Error: $error');
    });

    socket.onDisconnect((_) {
      print('❌ Socket Disconnected. Was Connected: ${socket.connected}');
    });
  }
  void subscribeToChannel(String channel, Function(dynamic) onEvent) {
    echo?.channel(channel).listen('EventName', (data) {
      onEvent(data);
    });
  }

  startTypingPersonal(loggedInUserId,loggedInName,toUserId)
  async {
    final socket = echo.connector.socket; // Access the underlying Socket.IO instance
    if (!socket.connected) {
      print('❌ Socket not connected. Current state: ${socket.connected}');
      return false;
    }
    String event = 'start-typing.2';
    String channelName = "private-chat";
    var data = {};
    // Format the event name correctly
    String formattedEvent = event.startsWith('client-') ? event : 'client-$event';

    // Format the channel name correctly
    String formattedChannel = channelName.startsWith('private-') ?
    channelName : 'private-$channelName';

    final payload = {
      'channel': formattedChannel,
      'event': formattedEvent,
      'data': data
    };

    try {
      print('🚀 Attempting to emit event:');
      print('Channel: $formattedChannel');
      print('Event: $formattedEvent');
      print('Payload: $payload');

      // Emit with acknowledgment callback
      Completer<bool> completer = Completer<bool>();

      socket.emitWithAck('client-event', payload, ack: (data) {
        print('✅ Event Acknowledged by server: $data');
        completer.complete(true);
      });

      // Wait for acknowledgment with timeout
      return await completer.future.timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('⏰ Event emission timed out');
          return false;
        },
      );

    } catch (e, stackTrace) {
      print('❌ Error sending whisper: $e');
      print('Stack trace: $stackTrace');
      return false;
    }
    // Construct the payload similar to what whisper would send
    // final payload = {
    //   'channel': 'private-chat', // Add 'private-' prefix for private channels
    //   'event': 'client-' + 'start-typing.${2}',   // Add 'client-' prefix for client-side events
    //   'data': {
    //     'user': { 'id': 3, 'name': 'user' },
    //     'typing': true,
    //   },
    // };
    //
    // // Emit the custom event
    // try{
    //   print("ccccccc${socket!.connected}");
    //   socket?.emit('client-event', payload);
    // }
    // catch(e)
    // {
    //   print("iiiiiiii${e}");
    // }
    // // echo.channel('ff').whisper('',{});
    // // echo.private('chat').
  }

  void disconnect() {
    echo?.connector.disconnect();
    // echo = null;
  }
}

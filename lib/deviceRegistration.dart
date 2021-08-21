import 'package:tattva_home/credentials.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


class confirm {
  final String RoomName;
  final String deviceName;
  final String deviceType;
  confirm(this.RoomName, this.deviceName, this.deviceType);

  @override
  void main() async {



    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);





    final firstObject=ParseObject('Rooms')
      ..set(
          'RoomName', this.RoomName);
    final secondObject = ParseObject('Devices')
      ..set(
          'deviceId', "1111111111")
      ..set(
          'deviceName', this.deviceName)
      ..set(
          'deviceType', this.deviceType);








    final test = ParseObject('FirstClass')
      ..set(
          'message', 'Hey ! First message from Flutter. Parse is now connected and registration page is running');
    await firstObject.save();
    await secondObject.save();
    await test.save();
//    parse






    print('done');
  }


}
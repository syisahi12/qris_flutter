String pad(int number) {
  return number < 10 ? '0$number' : number.toString();
}

String toCRC16(String input) {
  int crc = 0xFFFF;
  for (int i = 0; i < input.length; i++) {
    crc ^= input.codeUnitAt(i) << 8;
    for (int j = 0; j < 8; j++) {
      crc = (crc & 0x8000) != 0 ? (crc << 1) ^ 0x1021 : crc << 1;
    }
  }

  String hex = (crc & 0xFFFF).toRadixString(16).toUpperCase();
  return hex.length == 3 ? "0$hex" : hex;
}

String getBetween(String str, String start, String end) {
  final startIdx = str.indexOf(start);
  if (startIdx == -1) return "";
  final actualStartIdx = startIdx + start.length;
  final endIdx = str.indexOf(end, actualStartIdx);
  return str.substring(actualStartIdx, endIdx);
}

Map<String, dynamic> dataQris(String qris) {
  final nmid = "ID${getBetween(qris, "15ID", "0303")}";
  final id = qris.contains("A01") ? "A01" : "01";
  final merchantName = getBetween(qris, "ID59", "60").substring(2).trim().toUpperCase();

  final printData = RegExp(r'(?<=ID|COM).+?(?=0118)').allMatches(qris).map((m) => m.group(0)!).toList();
  final printCount = printData.length;
  final printerName = printData[printCount - 1].split('.');
  final printer = printerName.length == 3 ? printerName[1] : printerName[2];

  final nnsData = RegExp(r'(?<=0118).+?(?=ID)').allMatches(qris).map((m) => m.group(0)!).toList();
  final nns = nnsData[nnsData.length - 1].substring(0, 8);

  final crcInput = qris.substring(0, qris.length - 4);
  final crcFromQris = qris.substring(qris.length - 3);
  final crcComputed = toCRC16(crcInput);

  return {
    'nmid': nmid,
    'id': id,
    'merchantName': merchantName,
    'printer': printer,
    'nns': nns,
    'crcIsValid': crcFromQris == crcComputed
  };
}

String makeString(String qris, Map<String, String> params) {
  final nominal = params['nominal'];
  final taxtype = params['taxtype'] ?? 'p';
  final fee = params['fee'] ?? '0';

  if (qris.isEmpty) throw Exception('The parameter "qris" is required.');
  if (nominal == null || nominal.isEmpty) throw Exception('The parameter "nominal" is required.');

  String tax = '';
  String qrisModified = qris.substring(0, qris.length - 4).replaceAll("010211", "010212");
  List<String> qrisParts = qrisModified.split("5802ID");

  String amount = "54${pad(nominal.length)}$nominal";

  if (taxtype.isNotEmpty && fee.isNotEmpty) {
    tax = (taxtype == 'p')
        ? "55020357${pad(fee.length)}$fee"
        : "55020256${pad(fee.length)}$fee";
  }

  amount += (tax.isEmpty) ? "5802ID" : "${tax}5802ID";
  String output = "${qrisParts[0].trim()}$amount${qrisParts[1].trim()}";
  output += toCRC16(output);

  return output;
}
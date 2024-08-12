// This is only usable with android emulated devices running on the same machine than local server
// You will have to change this address in order to test the app on your physical device
// You can do this by launching the django server with a specific address as parameter and put that address here
// For example: "python manage.py runserver 192.0.0.1:8000" to launch the django server
// and bakoApiUri = 'http://192.168.0.66:8000
const String bakoApiUri = 'http://192.168.0.66:8000';

// ASR Model API URI and Authentication token
const String asrModelApiUri = 'https://tcfqs3chnpo7tvlx.us-east-1.aws.endpoints.huggingface.cloud';
const String asrModelApiToken = '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';

// We will probably get ride of those for a more scalable approach if application is deployed and maintained
const List<String> titles = ['A-ABCDaire', 'A-Denmisɛnya Kojuguw', 'A-Donfɛnw', 'A-Kulɔriw', 'B-Anw bɛ Baara Kɛ !', 'B-Baganw', 'B-Bama Miirina',
  'B-Sɔminiminɛnw', 'C-Jate', 'C-Kurun', 'C-Ne ni Mama ka Gafe Kalan', 'C-Ne ni Papa ka Gafe kalan', 'C-Nsbanji', 'C-Ni a tun bɛ se...',
  'C-Tulonkɛw', 'D-Fali Nalonma Ni Ba Kegunma', 'D-Kɛwale Ɲumanw', 'D-Namasatigi', 'D-Kogo', 'D-Sonsan Tulogɛlɛn', 'D-Yɛlɛ ka di Npogotiginin min y'];

const List<Map<String, String>> books = [
  {'title': 'A-ABCDaire', 'image': 'assets/Thumbnails/ABCD-256.png'},
  {'title': 'A-Denmisɛnya Kojuguw', 'image': 'assets/Thumbnails/DenmisenyaKojuguw-256.png'},
  {'title': 'A-Donfɛnw', 'image': 'assets/Thumbnails/Donfenw-256.png'},
  {'title': 'A-Kulɔriw', 'image': 'assets/Thumbnails/Kuloriw-256.png'},
  {'title': 'B-Anw bɛ Baara Kɛ !', 'image': 'assets/Thumbnails/AnwBeBaaraKe!-256.png'},
  {'title': 'B-Baganw', 'image': 'assets/Thumbnails/Baganw-256.png'},
  {'title': 'B-Bama Miirina', 'image': 'assets/Thumbnails/BamaMiirina-256.png'},
  {'title': 'B-Sɔminiminɛnw', 'image': 'assets/Thumbnails/Sominiminenw-256.png'},
  {'title': 'C-Jate', 'image': 'assets/Thumbnails/Jate-256.png'},
  {'title': 'C-Kurun', 'image': 'assets/Thumbnails/Kurun-256.png'},
  {'title': 'C-Ne ni Mama ka Gafe Kalan', 'image': 'assets/Thumbnails/NeNiMamaKaGafeKalan-256.png'},
  {'title': 'C-Ne ni Papa ka Gafe kalan', 'image': 'assets/Thumbnails/NeNiPapaKaGafeKalan-256.png'},
  {'title': 'C-Nsbanji', 'image': 'assets/Thumbnails/Nsabanji-256.png'},
  {'title': 'C-Ni a tun bɛ se...', 'image': 'assets/Thumbnails/NiATunBeSe-256.png'},
  {'title': 'C-Tulonkɛw', 'image': 'assets/Thumbnails/Tulonkew-256.png'},
  {'title': 'D-Fali Nalonma Ni Ba Kegunma', 'image': 'assets/Thumbnails/FaliNalonmaNiBaKegunma-256.png'},
  {'title': 'D-Kɛwale Ɲumanw', 'image': 'assets/Thumbnails/KewaleNumanw-256.png'},
  {'title': 'D-Namasatigi', 'image': 'assets/Thumbnails/Namasatigi-256.png'},
  {'title': 'D-Kogo', 'image': 'assets/Thumbnails/Kogo-256.png'},
  {'title': 'D-Sonsan Tulogɛlɛn', 'image': 'assets/Thumbnails/SonsanTulogelen-256.png'},
  {'title': 'D-Yɛlɛ ka di Npogotiginin min y', 'image': 'assets/Thumbnails/YeleKaDiNpogotigininMiYe-256.png'}
];

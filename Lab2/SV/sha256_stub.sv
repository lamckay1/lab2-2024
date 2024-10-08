//
// Secure Hash Standard (SHA-256)
//

module top #(parameter MSG_SIZE=24,
	     parameter PADDED_SIZE = 512)
   (input logic [MSG_SIZE-1:0] message,
    output logic [255:0] hashed);

   logic [PADDED_SIZE-1:0] padded;
	sha_padder #(MSG_SIZE,PADDED_SIZE) padder(message, padded);

	sha256 #(PADDED_SIZE) main(padded, hashed);
		
endmodule // sha_256

module sha_padder #(parameter MSG_SIZE = 24,
                    parameter PADDED_SIZE = 512)
   (input logic [MSG_SIZE-1:0] message,
    output logic [PADDED_SIZE-1:0] padded);

 //  localparam zero_width = PADDED_SIZE - MSG_SIZE - 64 - 1;
//	localparam backwidth = 64 - MSG_SIZE;

	assign padded = {message[23:0], 1'b1, {455{1'b0}}, MSG_SIZE};
endmodule // sha_padder

module sha256 #(parameter PADDED_SIZE = 512)
   (input logic [PADDED_SIZE-1:0] padded,
    output logic [255:0] hashed);   

   logic [255:0] H = {32'h6a09e667, 32'hbb67ae85,
		      32'h3c6ef372, 32'ha54ff53a, 32'h510e527f, 32'h9b05688c,
		      32'h1f83d9ab, 32'h5be0cd19};   
	
   logic [2047:0] K = {32'h428a2f98, 32'h71374491, 32'hb5c0fbcf,
		       32'he9b5dba5, 32'h3956c25b, 32'h59f111f1, 32'h923f82a4,
		       32'hab1c5ed5, 32'hd807aa98, 32'h12835b01, 32'h243185be,
		       32'h550c7dc3, 32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7,
		       32'hc19bf174, 32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6,
		       32'h240ca1cc, 32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc,
		       32'h76f988da, 32'h983e5152, 32'ha831c66d, 32'hb00327c8,
		       32'hbf597fc7, 32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351,
		       32'h14292967, 32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc,
		       32'h53380d13, 32'h650a7354, 32'h766a0abb, 32'h81c2c92e,
		       32'h92722c85, 32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70,
		       32'hc76c51a3, 32'hd192e819, 32'hd6990624, 32'hf40e3585,
		       32'h106aa070, 32'h19a4c116, 32'h1e376c08, 32'h2748774c,
		       32'h34b0bcb5, 32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f,
		       32'h682e6ff3, 32'h748f82ee, 32'h78a5636f, 32'h84c87814,
		       32'h8cc70208, 32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7,
		       32'hc67178f2};

   // Define your intermediate variables here (forgetting them assumes variables are 1-bit)
   logic [31:0]   a, b, c, d, e, f, g, h;
	logic [31:0]   an, bn, cn, dn, en, fn, gn, hn;
	logic [31:0]   an2, bn2, cn2, dn2, en2, fn2, gn2, hn2;
	logic [31:0]   an3, bn3, cn3, dn3, en3, fn3, gn3, hn3;
logic [31:0]   an4, bn4, cn4, dn4, en4, fn4, gn4, hn4;
logic [31:0]   an5, bn5, cn5, dn5, en5, fn5, gn5, hn5;
logic [31:0]   an6, bn6, cn6, dn6, en6, fn6, gn6, hn6;
logic [31:0]   an7, bn7, cn7, dn7, en7, fn7, gn7, hn7;
logic [31:0]   an8, bn8, cn8, dn8, en8, fn8, gn8, hn8;
logic [31:0]   an9, bn9, cn9, dn9, en9, fn9, gn9, hn9;
logic [31:0]   an10, bn10, cn10, dn10, en10, fn10, gn10, hn10;
logic [31:0]   an11, bn11, cn11, dn11, en11, fn11, gn11, hn11;
logic [31:0]   an12, bn12, cn12, dn12, en12, fn12, gn12, hn12;
logic [31:0]   an13, bn13, cn13, dn13, en13, fn13, gn13, hn13;
logic [31:0]   an14, bn14, cn14, dn14, en14, fn14, gn14, hn14;
logic [31:0]   an15, bn15, cn15, dn15, en15, fn15, gn15, hn15;
logic [31:0]   an16, bn16, cn16, dn16, en16, fn16, gn16, hn16;
logic [31:0]   an17, bn17, cn17, dn17, en17, fn17, gn17, hn17;
logic [31:0]   an18, bn18, cn18, dn18, en18, fn18, gn18, hn18;
logic [31:0]   an19, bn19, cn19, dn19, en19, fn19, gn19, hn19;
logic [31:0]   an20, bn20, cn20, dn20, en20, fn20, gn20, hn20;
logic [31:0]   an21, bn21, cn21, dn21, en21, fn21, gn21, hn21;
logic [31:0]   an22, bn22, cn22, dn22, en22, fn22, gn22, hn22;
logic [31:0]   an23, bn23, cn23, dn23, en23, fn23, gn23, hn23;
logic [31:0]   an24, bn24, cn24, dn24, en24, fn24, gn24, hn24;
logic [31:0]   an25, bn25, cn25, dn25, en25, fn25, gn25, hn25;
logic [31:0]   an26, bn26, cn26, dn26, en26, fn26, gn26, hn26;
logic [31:0]   an27, bn27, cn27, dn27, en27, fn27, gn27, hn27;
logic [31:0]   an28, bn28, cn28, dn28, en28, fn28, gn28, hn28;
logic [31:0]   an29, bn29, cn29, dn29, en29, fn29, gn29, hn29;
logic [31:0]   an30, bn30, cn30, dn30, en30, fn30, gn30, hn30;
logic [31:0]   an31, bn31, cn31, dn31, en31, fn31, gn31, hn31;
logic [31:0]   an32, bn32, cn32, dn32, en32, fn32, gn32, hn32;
logic [31:0]   an33, bn33, cn33, dn33, en33, fn33, gn33, hn33;
logic [31:0]   an34, bn34, cn34, dn34, en34, fn34, gn34, hn34;
logic [31:0]   an35, bn35, cn35, dn35, en35, fn35, gn35, hn35;
logic [31:0]   an36, bn36, cn36, dn36, en36, fn36, gn36, hn36;
logic [31:0]   an37, bn37, cn37, dn37, en37, fn37, gn37, hn37;
logic [31:0]   an38, bn38, cn38, dn38, en38, fn38, gn38, hn38;
logic [31:0]   an39, bn39, cn39, dn39, en39, fn39, gn39, hn39;
logic [31:0]   an40, bn40, cn40, dn40, en40, fn40, gn40, hn40;
logic [31:0]   an41, bn41, cn41, dn41, en41, fn41, gn41, hn41;
logic [31:0]   an42, bn42, cn42, dn42, en42, fn42, gn42, hn42;
logic [31:0]   an43, bn43, cn43, dn43, en43, fn43, gn43, hn43;
logic [31:0]   an44, bn44, cn44, dn44, en44, fn44, gn44, hn44;
logic [31:0]   an45, bn45, cn45, dn45, en45, fn45, gn45, hn45;
logic [31:0]   an46, bn46, cn46, dn46, en46, fn46, gn46, hn46;
logic [31:0]   an47, bn47, cn47, dn47, en47, fn47, gn47, hn47;
logic [31:0]   an48, bn48, cn48, dn48, en48, fn48, gn48, hn48;
logic [31:0]   an49, bn49, cn49, dn49, en49, fn49, gn49, hn49;
logic [31:0]   an50, bn50, cn50, dn50, en50, fn50, gn50, hn50;
logic [31:0]   an51, bn51, cn51, dn51, en51, fn51, gn51, hn51;
logic [31:0]   an52, bn52, cn52, dn52, en52, fn52, gn52, hn52;
logic [31:0]   an53, bn53, cn53, dn53, en53, fn53, gn53, hn53;
logic [31:0]   an54, bn54, cn54, dn54, en54, fn54, gn54, hn54;
logic [31:0]   an55, bn55, cn55, dn55, en55, fn55, gn55, hn55;
logic [31:0]   an56, bn56, cn56, dn56, en56, fn56, gn56, hn56;
logic [31:0]   an57, bn57, cn57, dn57, en57, fn57, gn57, hn57;
logic [31:0]   an58, bn58, cn58, dn58, en58, fn58, gn58, hn58;
logic [31:0]   an59, bn59, cn59, dn59, en59, fn59, gn59, hn59;
logic [31:0]   an60, bn60, cn60, dn60, en60, fn60, gn60, hn60;
logic [31:0]   an61, bn61, cn61, dn61, en61, fn61, gn61, hn61;
logic [31:0]   an62, bn62, cn62, dn62, en62, fn62, gn62, hn62;
	logic [31:0]   an63, bn63, cn63, dn63, en63, fn63, gn63, hn63;
	logic [31:0]   an64, bn64, cn64, dn64, en64, fn64, gn64, hn64;
   logic [31:0]   h0o, h1o, h2o, h3o, h4o, h5o, h6o, h7o;

   // Initialize a through h
  assign a = H[255:224];
   assign b = H[223:192];
   assign c = H[191:160];
   assign d = H[159:128];
   assign e = H[127:96];
   assign f = H[95:64];
   assign g = H[63:32];
   assign h = H[31:0];

	logic [31:0]W0, W1, W2, W3, W4, 
		W5, W6, W7, W8, W9,
		W10, W11, W12, W13, W14, 
		W15, W16, W17, W18, W19,
		W20, W21, W22, W23, W24, 
		W25, W26, W27, W28, W29,
		W30, W31, W32, W33, W34, 
		W35, W36, W37, W38, W39,
		W40, W41, W42, W43, W44, 
		W45, W46, W47, W48, W49,
		W50, W51, W52, W53, W54, 
		W55, W56, W57, W58, W59,
		W60, W61, W62, W63;
	
prepare p1 (padded[511:480], padded[479:448], padded[447:416],
               padded[415:384], padded[383:352], padded[351:320],
               padded[319:288], padded[287:256], padded[255:224],
               padded[223:192], padded[191:160], padded[159:128],
               padded[127:96], padded[95:64], padded[63:32],
               padded[31:0], W0, W1, W2, W3, W4, W5, W6, W7, W8, W9,
               W10, W11, W12, W13, W14, W15, W16, W17, W18, W19,
               W20, W21, W22, W23, W24, W25, W26, W27, W28, W29,
               W30, W31, W32, W33, W34, W35, W36, W37, W38, W39,
               W40, W41, W42, W43, W44, W45, W46, W47, W48, W49,
               W50, W51, W52, W53, W54, W55, W56, W57, W58, W59,
               W60, W61, W62, W63);
	
   // 64 hash computations   
	
	main_comp mc01 (a, b, c, d, e, f, g, h, K[2047:2016], W0, an, bn, cn, dn, en, fn, gn, hn); 
main_comp mc02 (an, bn, cn, dn, en, fn, gn, hn, K[2015:1984], W1, an2, bn2, cn2, dn2, en2, fn2, gn2, hn2); 
main_comp mc03 (an2, bn2, cn2, dn2, en2, fn2, gn2, hn2, K[1983:1952], W2, an3, bn3, cn3, dn3, en3, fn3, gn3, hn3); 
main_comp mc04 (an3, bn3, cn3, dn3, en3, fn3, gn3, hn3, K[1951:1920], W3, an4, bn4, cn4, dn4, en4, fn4, gn4, hn4); 
main_comp mc05 (an4, bn4, cn4, dn4, en4, fn4, gn4, hn4, K[1919:1888], W4, an5, bn5, cn5, dn5, en5, fn5, gn5, hn5); 
main_comp mc06 (an5, bn5, cn5, dn5, en5, fn5, gn5, hn5, K[1887:1856], W5, an6, bn6, cn6, dn6, en6, fn6, gn6, hn6); 
main_comp mc07 (an6, bn6, cn6, dn6, en6, fn6, gn6, hn6, K[1855:1824], W6, an7, bn7, cn7, dn7, en7, fn7, gn7, hn7); 
main_comp mc08 (an7, bn7, cn7, dn7, en7, fn7, gn7, hn7, K[1823:1792], W7, an8, bn8, cn8, dn8, en8, fn8, gn8, hn8); 
main_comp mc09 (an8, bn8, cn8, dn8, en8, fn8, gn8, hn8, K[1791:1760], W8, an9, bn9, cn9, dn9, en9, fn9, gn9, hn9); 
main_comp mc10 (an9, bn9, cn9, dn9, en9, fn9, gn9, hn9, K[1759:1728], W9, an10, bn10, cn10, dn10, en10, fn10, gn10, hn10); 
main_comp mc11 (an10, bn10, cn10, dn10, en10, fn10, gn10, hn10, K[1727:1696], W10, an11, bn11, cn11, dn11, en11, fn11, gn11, hn11); 
main_comp mc12 (an11, bn11, cn11, dn11, en11, fn11, gn11, hn11, K[1695:1664], W11, an12, bn12, cn12, dn12, en12, fn12, gn12, hn12); 
main_comp mc13 (an12, bn12, cn12, dn12, en12, fn12, gn12, hn12, K[1663:1632], W12, an13, bn13, cn13, dn13, en13, fn13, gn13, hn13); 
main_comp mc14 (an13, bn13, cn13, dn13, en13, fn13, gn13, hn13, K[1631:1600], W13, an14, bn14, cn14, dn14, en14, fn14, gn14, hn14); 
main_comp mc15 (an14, bn14, cn14, dn14, en14, fn14, gn14, hn14, K[1599:1568], W14, an15, bn15, cn15, dn15, en15, fn15, gn15, hn15); 
main_comp mc16 (an15, bn15, cn15, dn15, en15, fn15, gn15, hn15, K[1567:1536], W15, an16, bn16, cn16, dn16, en16, fn16, gn16, hn16); 
main_comp mc17 (an16, bn16, cn16, dn16, en16, fn16, gn16, hn16, K[1535:1504], W16, an17, bn17, cn17, dn17, en17, fn17, gn17, hn17); 
main_comp mc18 (an17, bn17, cn17, dn17, en17, fn17, gn17, hn17, K[1503:1472], W17, an18, bn18, cn18, dn18, en18, fn18, gn18, hn18); 
main_comp mc19 (an18, bn18, cn18, dn18, en18, fn18, gn18, hn18, K[1471:1440], W18, an19, bn19, cn19, dn19, en19, fn19, gn19, hn19); 
main_comp mc20 (an19, bn19, cn19, dn19, en19, fn19, gn19, hn19, K[1439:1408], W19, an20, bn20, cn20, dn20, en20, fn20, gn20, hn20); 
main_comp mc21 (an20, bn20, cn20, dn20, en20, fn20, gn20, hn20, K[1407:1376], W20, an21, bn21, cn21, dn21, en21, fn21, gn21, hn21); 
main_comp mc22 (an21, bn21, cn21, dn21, en21, fn21, gn21, hn21, K[1375:1344], W21, an22, bn22, cn22, dn22, en22, fn22, gn22, hn22); 
main_comp mc23 (an22, bn22, cn22, dn22, en22, fn22, gn22, hn22, K[1343:1312], W22, an23, bn23, cn23, dn23, en23, fn23, gn23, hn23); 
main_comp mc24 (an23, bn23, cn23, dn23, en23, fn23, gn23, hn23, K[1311:1280], W23, an24, bn24, cn24, dn24, en24, fn24, gn24, hn24); 
main_comp mc25 (an24, bn24, cn24, dn24, en24, fn24, gn24, hn24, K[1279:1248], W24, an25, bn25, cn25, dn25, en25, fn25, gn25, hn25); 
main_comp mc26 (an25, bn25, cn25, dn25, en25, fn25, gn25, hn25, K[1247:1216], W25, an26, bn26, cn26, dn26, en26, fn26, gn26, hn26); 
main_comp mc27 (an26, bn26, cn26, dn26, en26, fn26, gn26, hn26, K[1215:1184], W26, an27, bn27, cn27, dn27, en27, fn27, gn27, hn27); 
main_comp mc28 (an27, bn27, cn27, dn27, en27, fn27, gn27, hn27, K[1183:1152], W27, an28, bn28, cn28, dn28, en28, fn28, gn28, hn28); 
main_comp mc29 (an28, bn28, cn28, dn28, en28, fn28, gn28, hn28, K[1151:1120], W28, an29, bn29, cn29, dn29, en29, fn29, gn29, hn29); 
main_comp mc30 (an29, bn29, cn29, dn29, en29, fn29, gn29, hn29, K[1119:1088], W29, an30, bn30, cn30, dn30, en30, fn30, gn30, hn30); 
main_comp mc31 (an30, bn30, cn30, dn30, en30, fn30, gn30, hn30, K[1087:1056], W30, an31, bn31, cn31, dn31, en31, fn31, gn31, hn31); 
main_comp mc32 (an31, bn31, cn31, dn31, en31, fn31, gn31, hn31, K[1055:1024], W31, an32, bn32, cn32, dn32, en32, fn32, gn32, hn32);
main_comp mc33 (an32, bn32, cn32, dn32, en32, fn32, gn32, hn32, K[1023:992], W32, an33, bn33, cn33, dn33, en33, fn33, gn33, hn33);
main_comp mc34 (an33, bn33, cn33, dn33, en33, fn33, gn33, hn33, K[991:960], W33, an34, bn34, cn34, dn34, en34, fn34, gn34, hn34); 
main_comp mc35 (an34, bn34, cn34, dn34, en34, fn34, gn34, hn34, K[959:928], W34, an35, bn35, cn35, dn35, en35, fn35, gn35, hn35); 
main_comp mc36 (an35, bn35, cn35, dn35, en35, fn35, gn35, hn35, K[927:896], W35, an36, bn36, cn36, dn36, en36, fn36, gn36, hn36); 
main_comp mc37 (an36, bn36, cn36, dn36, en36, fn36, gn36, hn36, K[895:864], W36, an37, bn37, cn37, dn37, en37, fn37, gn37, hn37); 
main_comp mc38 (an37, bn37, cn37, dn37, en37, fn37, gn37, hn37, K[863:832], W37, an38, bn38, cn38, dn38, en38, fn38, gn38, hn38); 
main_comp mc39 (an38, bn38, cn38, dn38, en38, fn38, gn38, hn38, K[831:800], W38, an39, bn39, cn39, dn39, en39, fn39, gn39, hn39); 
main_comp mc40 (an39, bn39, cn39, dn39, en39, fn39, gn39, hn39, K[799:768], W39, an40, bn40, cn40, dn40, en40, fn40, gn40, hn40); 
main_comp mc41 (an40, bn40, cn40, dn40, en40, fn40, gn40, hn40, K[767:736], W40, an41, bn41, cn41, dn41, en41, fn41, gn41, hn41); 
main_comp mc42 (an41, bn41, cn41, dn41, en41, fn41, gn41, hn41, K[735:704], W41, an42, bn42, cn42, dn42, en42, fn42, gn42, hn42); 
main_comp mc43 (an42, bn42, cn42, dn42, en42, fn42, gn42, hn42, K[703:672], W42, an43, bn43, cn43, dn43, en43, fn43, gn43, hn43); 
main_comp mc44 (an43, bn43, cn43, dn43, en43, fn43, gn43, hn43, K[671:640], W43, an44, bn44, cn44, dn44, en44, fn44, gn44, hn44); 
main_comp mc45 (an44, bn44, cn44, dn44, en44, fn44, gn44, hn44, K[639:608], W44, an45, bn45, cn45, dn45, en45, fn45, gn45, hn45); 
main_comp mc46 (an45, bn45, cn45, dn45, en45, fn45, gn45, hn45, K[607:576], W45, an46, bn46, cn46, dn46, en46, fn46, gn46, hn46); 
main_comp mc47 (an46, bn46, cn46, dn46, en46, fn46, gn46, hn46, K[575:544], W46, an47, bn47, cn47, dn47, en47, fn47, gn47, hn47); 
main_comp mc48 (an47, bn47, cn47, dn47, en47, fn47, gn47, hn47, K[543:512], W47, an48, bn48, cn48, dn48, en48, fn48, gn48, hn48); 
main_comp mc49 (an48, bn48, cn48, dn48, en48, fn48, gn48, hn48, K[511:480], W48, an49, bn49, cn49, dn49, en49, fn49, gn49, hn49); 
main_comp mc50 (an49, bn49, cn49, dn49, en49, fn49, gn49, hn49, K[479:448], W49, an50, bn50, cn50, dn50, en50, fn50, gn50, hn50); 
main_comp mc51 (an50, bn50, cn50, dn50, en50, fn50, gn50, hn50, K[447:416], W50, an51, bn51, cn51, dn51, en51, fn51, gn51, hn51); 
main_comp mc52 (an51, bn51, cn51, dn51, en51, fn51, gn51, hn51, K[415:384], W51, an52, bn52, cn52, dn52, en52, fn52, gn52, hn52); 
main_comp mc53 (an52, bn52, cn52, dn52, en52, fn52, gn52, hn52, K[383:352], W52, an53, bn53, cn53, dn53, en53, fn53, gn53, hn53); 
main_comp mc54 (an53, bn53, cn53, dn53, en53, fn53, gn53, hn53, K[351:320], W53, an54, bn54, cn54, dn54, en54, fn54, gn54, hn54); 
main_comp mc55 (an54, bn54, cn54, dn54, en54, fn54, gn54, hn54, K[319:288], W54, an55, bn55, cn55, dn55, en55, fn55, gn55, hn55); 
main_comp mc56 (an55, bn55, cn55, dn55, en55, fn55, gn55, hn55, K[287:256], W55, an56, bn56, cn56, dn56, en56, fn56, gn56, hn56); 
main_comp mc57 (an56, bn56, cn56, dn56, en56, fn56, gn56, hn56, K[255:224], W56, an57, bn57, cn57, dn57, en57, fn57, gn57, hn57); 
main_comp mc58 (an57, bn57, cn57, dn57, en57, fn57, gn57, hn57, K[223:192], W57, an58, bn58, cn58, dn58, en58, fn58, gn58, hn58); 
main_comp mc59 (an58, bn58, cn58, dn58, en58, fn58, gn58, hn58, K[191:160], W58, an59, bn59, cn59, dn59, en59, fn59, gn59, hn59); 
main_comp mc60 (an59, bn59, cn59, dn59, en59, fn59, gn59, hn59, K[159:128], W59, an60, bn60, cn60, dn60, en60, fn60, gn60, hn60); 
main_comp mc61 (an60, bn60, cn60, dn60, en60, fn60, gn60, hn60, K[127:96], W60, an61, bn61, cn61, dn61, en61, fn61, gn61, hn61); 
main_comp mc62 (an61, bn61, cn61, dn61, en61, fn61, gn61, hn61, K[95:64], W61, an62, bn62, cn62, dn62, en62, fn62, gn62, hn62); 
main_comp mc63 (an62, bn62, cn62, dn62, en62, fn62, gn62, hn62, K[63:32], W62, an63, bn63, cn63, dn63, en63, fn63, gn63, hn63); 
main_comp mc64 (an63, bn63, cn63, dn63, en63, fn63, gn63, hn63, K[31:0], W63, an64, bn64, cn64, dn64, en64, fn64, gn64, hn64);





	intermediate_hash ih1 (an64, bn64, cn64, dn64, en64, fn64, gn64, hn64,
			   			   a, b, c, d, e, f, g, h, 
			   			   h0o, h1o, h2o, h3o, h4o, h5o, h6o, h7o);
   // Final output
	assign hashed = {h0o, h1o, h2o, h3o, h4o, h5o, h6o, h7o};

endmodule // sha_main

module prepare (input logic [31:0] M0, M1, M2, M3,
		input logic [31:0]  M4, M5, M6, M7,
		input logic [31:0]  M8, M9, M10, M11,
		input logic [31:0]  M12, M13, M14, M15,
		output logic [31:0] W0, W1, W2, W3, W4, 
		output logic [31:0] W5, W6, W7, W8, W9,
		output logic [31:0] W10, W11, W12, W13, W14, 
		output logic [31:0] W15, W16, W17, W18, W19,
		output logic [31:0] W20, W21, W22, W23, W24, 
		output logic [31:0] W25, W26, W27, W28, W29,
		output logic [31:0] W30, W31, W32, W33, W34, 
		output logic [31:0] W35, W36, W37, W38, W39,
		output logic [31:0] W40, W41, W42, W43, W44, 
		output logic [31:0] W45, W46, W47, W48, W49,
		output logic [31:0] W50, W51, W52, W53, W54, 
		output logic [31:0] W55, W56, W57, W58, W59,
		output logic [31:0] W60, W61, W62, W63);

	logic [31:0] W14_sigma1_out,
W15_sigma1_out,
W16_sigma1_out,
W17_sigma1_out,
W18_sigma1_out,
W19_sigma1_out,
W20_sigma1_out,
W21_sigma1_out,
W22_sigma1_out,
W23_sigma1_out,
W24_sigma1_out,
W25_sigma1_out,
W26_sigma1_out,
W27_sigma1_out,
W28_sigma1_out,
W29_sigma1_out,
W30_sigma1_out,
W31_sigma1_out,
W32_sigma1_out,
W33_sigma1_out,
W34_sigma1_out,
W35_sigma1_out,
W36_sigma1_out,
W37_sigma1_out,
W38_sigma1_out,
W39_sigma1_out,
W40_sigma1_out,
W41_sigma1_out,
W42_sigma1_out,
W43_sigma1_out,
W44_sigma1_out,
W45_sigma1_out,
W46_sigma1_out,
W47_sigma1_out,
W48_sigma1_out,
W49_sigma1_out,
W50_sigma1_out,
W51_sigma1_out,
W52_sigma1_out,
W53_sigma1_out,
W54_sigma1_out,
W55_sigma1_out,
W56_sigma1_out,
W57_sigma1_out,
W58_sigma1_out,
W59_sigma1_out,
W60_sigma1_out,
W61_sigma1_out,
W1_sigma0_out,
W2_sigma0_out,
W3_sigma0_out,
W4_sigma0_out,
W5_sigma0_out,
W6_sigma0_out,
W7_sigma0_out,
W8_sigma0_out,
W9_sigma0_out,
W10_sigma0_out,
W11_sigma0_out,
W12_sigma0_out,
W13_sigma0_out,
W14_sigma0_out,
W15_sigma0_out,
W16_sigma0_out,
W17_sigma0_out,
W18_sigma0_out,
W19_sigma0_out,
W20_sigma0_out,
W21_sigma0_out,
W22_sigma0_out,
W23_sigma0_out,
W24_sigma0_out,
W25_sigma0_out,
W26_sigma0_out,
W27_sigma0_out,
W28_sigma0_out,
W29_sigma0_out,
W30_sigma0_out,
W31_sigma0_out,
W32_sigma0_out,
W33_sigma0_out,
W34_sigma0_out,
W35_sigma0_out,
W36_sigma0_out,
W37_sigma0_out,
W38_sigma0_out,
W39_sigma0_out,
W40_sigma0_out,
W41_sigma0_out,
W42_sigma0_out,
W43_sigma0_out,
W44_sigma0_out,
W45_sigma0_out,
W46_sigma0_out,
W47_sigma0_out,
W48_sigma0_out;


	
	assign W0 = M0;
	assign W1 = M1;
	assign W2 = M2;
	assign W3 = M3;
	assign W4 = M4;
	assign W5 = M5;
	assign W6 = M6;
	assign W7 = M7;
	assign W8 = M8;
	assign W9 = M9;
	assign W10 = M10;
	assign W11 = M11;
	assign W12 = M12;
	assign W13 = M13;
	assign W14 = M14;
	assign W15 = M15;

	
	
// sigma 1 (see bottom of page 6)
	sigma1 sig1_1 (W14, W14_sigma1_out);
	sigma1 sig1_2 (W15, W15_sigma1_out);
	sigma1 sig1_3 (W16, W16_sigma1_out);
	sigma1 sig1_4 (W17, W17_sigma1_out);
	sigma1 sig1_5 (W18, W18_sigma1_out);
	sigma1 sig1_6 (W19, W19_sigma1_out);
	sigma1 sig1_7 (W20, W20_sigma1_out);
	sigma1 sig1_8 (W21, W21_sigma1_out);
	sigma1 sig1_9 (W22, W22_sigma1_out);
	sigma1 sig1_10 (W23, W23_sigma1_out);
	sigma1 sig1_11 (W24, W24_sigma1_out);
	sigma1 sig1_12 (W25, W25_sigma1_out);
	sigma1 sig1_13 (W26, W26_sigma1_out);
	sigma1 sig1_14 (W27, W27_sigma1_out);
	sigma1 sig1_15 (W28, W28_sigma1_out);
	sigma1 sig1_16 (W29, W29_sigma1_out);
	sigma1 sig1_17 (W30, W30_sigma1_out);
	sigma1 sig1_18 (W31, W31_sigma1_out);
	sigma1 sig1_19 (W32, W32_sigma1_out);
	sigma1 sig1_20 (W33, W33_sigma1_out);
	sigma1 sig1_21 (W34, W34_sigma1_out);
	sigma1 sig1_22 (W35, W35_sigma1_out);
	sigma1 sig1_23 (W36, W36_sigma1_out);
	sigma1 sig1_24 (W37, W37_sigma1_out);
	sigma1 sig1_25 (W38, W38_sigma1_out);
	sigma1 sig1_26 (W39, W39_sigma1_out);
	sigma1 sig1_27 (W40, W40_sigma1_out);
	sigma1 sig1_28 (W41, W41_sigma1_out);
	sigma1 sig1_29 (W42, W42_sigma1_out);
	sigma1 sig1_30 (W43, W43_sigma1_out);
	sigma1 sig1_31 (W44, W44_sigma1_out);
	sigma1 sig1_32 (W45, W45_sigma1_out);
	sigma1 sig1_33 (W46, W46_sigma1_out);
	sigma1 sig1_34 (W47, W47_sigma1_out);
	sigma1 sig1_35 (W48, W48_sigma1_out);
	sigma1 sig1_36 (W49, W49_sigma1_out);
	sigma1 sig1_37 (W50, W50_sigma1_out);
	sigma1 sig1_38 (W51, W51_sigma1_out);
	sigma1 sig1_39 (W52, W52_sigma1_out);
	sigma1 sig1_40 (W53, W53_sigma1_out);
	sigma1 sig1_41 (W54, W54_sigma1_out);
	sigma1 sig1_42 (W55, W55_sigma1_out);
	sigma1 sig1_43 (W56, W56_sigma1_out);
	sigma1 sig1_44 (W57, W57_sigma1_out);
	sigma1 sig1_45 (W58, W58_sigma1_out);
	sigma1 sig1_46 (W59, W59_sigma1_out);
	sigma1 sig1_47 (W60, W60_sigma1_out);
	sigma1 sig1_48 (W61, W61_sigma1_out);




   // sigma 0 (see bottom of page 6)
	sigma0 sig0_1 (W1, W1_sigma0_out);
	sigma0 sig0_2 (W2, W2_sigma0_out);
	sigma0 sig0_3 (W3, W3_sigma0_out);
	sigma0 sig0_4 (W4, W4_sigma0_out);
	sigma0 sig0_5 (W5, W5_sigma0_out);
	sigma0 sig0_6 (W6, W6_sigma0_out);
	sigma0 sig0_7 (W7, W7_sigma0_out);
	sigma0 sig0_8 (W8, W8_sigma0_out);
	sigma0 sig0_9 (W9, W9_sigma0_out);
	sigma0 sig0_10 (W10, W10_sigma0_out);
	sigma0 sig0_11 (W11, W11_sigma0_out);
	sigma0 sig0_12 (W12, W12_sigma0_out);
	sigma0 sig0_13 (W13, W13_sigma0_out);
	sigma0 sig0_14 (W14, W14_sigma0_out);
	sigma0 sig0_15 (W15, W15_sigma0_out);
	sigma0 sig0_16 (W16, W16_sigma0_out);
	sigma0 sig0_17 (W17, W17_sigma0_out);
	sigma0 sig0_18 (W18, W18_sigma0_out);
	sigma0 sig0_19 (W19, W19_sigma0_out);
	sigma0 sig0_20 (W20, W20_sigma0_out);
	sigma0 sig0_21 (W21, W21_sigma0_out);
	sigma0 sig0_22 (W22, W22_sigma0_out);
	sigma0 sig0_23 (W23, W23_sigma0_out);
	sigma0 sig0_24 (W24, W24_sigma0_out);
	sigma0 sig0_25 (W25, W25_sigma0_out);
	sigma0 sig0_26 (W26, W26_sigma0_out);
	sigma0 sig0_27 (W27, W27_sigma0_out);
	sigma0 sig0_28 (W28, W28_sigma0_out);
	sigma0 sig0_29 (W29, W29_sigma0_out);
	sigma0 sig0_30 (W30, W30_sigma0_out);
	sigma0 sig0_31 (W31, W31_sigma0_out);
	sigma0 sig0_32 (W32, W32_sigma0_out);
	sigma0 sig0_33 (W33, W33_sigma0_out);
	sigma0 sig0_34 (W34, W34_sigma0_out);
	sigma0 sig0_35 (W35, W35_sigma0_out);
	sigma0 sig0_36 (W36, W36_sigma0_out);
	sigma0 sig0_37 (W37, W37_sigma0_out);
	sigma0 sig0_38 (W38, W38_sigma0_out);
	sigma0 sig0_39 (W39, W39_sigma0_out);
	sigma0 sig0_40 (W40, W40_sigma0_out);
	sigma0 sig0_41 (W41, W41_sigma0_out);
	sigma0 sig0_42 (W42, W42_sigma0_out);
	sigma0 sig0_43 (W43, W43_sigma0_out);
	sigma0 sig0_44 (W44, W44_sigma0_out);
	sigma0 sig0_45 (W45, W45_sigma0_out);
	sigma0 sig0_46 (W46, W46_sigma0_out);
	sigma0 sig0_47 (W47, W47_sigma0_out);
	sigma0 sig0_48 (W48, W48_sigma0_out);

   // fill in other sigma0 blocks

   // Equation for W_i (top of page 7)
	assign W16 = W14_sigma1_out + W9 + W1_sigma0_out + W0;
	assign W17 = W15_sigma1_out + W10 + W2_sigma0_out + W1;
	assign W18 = W16_sigma1_out + W11 + W3_sigma0_out + W2;
	assign W19 = W17_sigma1_out + W12 + W4_sigma0_out + W3;
	assign W20 = W18_sigma1_out + W13 + W5_sigma0_out + W4;
	assign W21 = W19_sigma1_out + W14 + W6_sigma0_out + W5;
	assign W22 = W20_sigma1_out + W15 + W7_sigma0_out + W6;
	assign W23 = W21_sigma1_out + W16 + W8_sigma0_out + W7;
	assign W24 = W22_sigma1_out + W17 + W9_sigma0_out + W8;
	assign W25 = W23_sigma1_out + W18 + W10_sigma0_out + W9;
	assign W26 = W24_sigma1_out + W19 + W11_sigma0_out + W10;
	assign W27 = W25_sigma1_out + W20 + W12_sigma0_out + W11;
	assign W28 = W26_sigma1_out + W21 + W13_sigma0_out + W12;
	assign W29 = W27_sigma1_out + W22 + W14_sigma0_out + W13;
	assign W30 = W28_sigma1_out + W23 + W15_sigma0_out + W14;
	assign W31 = W29_sigma1_out + W24 + W16_sigma0_out + W15;
	assign W32 = W30_sigma1_out + W25 + W17_sigma0_out + W16;
	assign W33 = W31_sigma1_out + W26 + W18_sigma0_out + W17;
	assign W34 = W32_sigma1_out + W27 + W19_sigma0_out + W18;
	assign W35 = W33_sigma1_out + W28 + W20_sigma0_out + W19;
	assign W36 = W34_sigma1_out + W29 + W21_sigma0_out + W20;
	assign W37 = W35_sigma1_out + W30 + W22_sigma0_out + W21;
	assign W38 = W36_sigma1_out + W31 + W23_sigma0_out + W22;
	assign W39 = W37_sigma1_out + W32 + W24_sigma0_out + W23;
	assign W40 = W38_sigma1_out + W33 + W25_sigma0_out + W24;
	assign W41 = W39_sigma1_out + W34 + W26_sigma0_out + W25;
	assign W42 = W40_sigma1_out + W35 + W27_sigma0_out + W26;
	assign W43 = W41_sigma1_out + W36 + W28_sigma0_out + W27;
	assign W44 = W42_sigma1_out + W37 + W29_sigma0_out + W28;
	assign W45 = W43_sigma1_out + W38 + W30_sigma0_out + W29;
	assign W46 = W44_sigma1_out + W39 + W31_sigma0_out + W30;
	assign W47 = W45_sigma1_out + W40 + W32_sigma0_out + W31;
	assign W48 = W46_sigma1_out + W41 + W33_sigma0_out + W32;
	assign W49 = W47_sigma1_out + W42 + W34_sigma0_out + W33;
	assign W50 = W48_sigma1_out + W43 + W35_sigma0_out + W34;
	assign W51 = W49_sigma1_out + W44 + W36_sigma0_out + W35;
	assign W52 = W50_sigma1_out + W45 + W37_sigma0_out + W36;
	assign W53 = W51_sigma1_out + W46 + W38_sigma0_out + W37;
	assign W54 = W52_sigma1_out + W47 + W39_sigma0_out + W38;
	assign W55 = W53_sigma1_out + W48 + W40_sigma0_out + W39;
	assign W56 = W54_sigma1_out + W49 + W41_sigma0_out + W40;
	assign W57 = W55_sigma1_out + W50 + W42_sigma0_out + W41;
	assign W58 = W56_sigma1_out + W51 + W43_sigma0_out + W42;
	assign W59 = W57_sigma1_out + W52 + W44_sigma0_out + W43;
	assign W60 = W58_sigma1_out + W53 + W45_sigma0_out + W44;
	assign W61 = W59_sigma1_out + W54 + W46_sigma0_out + W45;
	assign W62 = W60_sigma1_out + W55 + W47_sigma0_out + W46;
	assign W63 = W61_sigma1_out + W56 + W48_sigma0_out + W47;

	
endmodule // prepare


module main_comp (input logic [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
		  input logic [31:0] K_in, W_in,
		  output logic [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out,
		  output logic [31:0] h_out);


	logic[31:0] T1, T2;

	logic [31:0] s1, s0, cho, maj;
	Sigma1 S1(e_in, s1);
	choice cho1(e_in, f_in, g_in, cho);
	Sigma0 S0(a_in, s0);
	majority Maj(a_in, b_in, c_in, maj);

	assign T1 = h_in[31:0] + s1[31:0] + cho[31:0] + K_in[31:0] + W_in[31:0];
	assign T2 = s0[31:0] + maj[31:0];

	assign a_out = T1 + T2;
	assign b_out = a_in;
	assign c_out = b_in;
	assign d_out = c_in;
	assign e_out = d_in + T1;
	assign f_out = e_in;
	assign g_out = f_in;
	assign h_out = g_in;

endmodule // main_comp

module intermediate_hash (input logic [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
			  input logic [31:0]  h0_in, h1_in, h2_in, h3_in, h4_in, h5_in, h6_in, h7_in, 
			  output logic [31:0] h0_out, h1_out, h2_out, h3_out, h4_out, h5_out, h6_out, h7_out);

   assign h0_out = a_in + h0_in;
   assign h1_out = b_in + h1_in;
   assign h2_out = c_in + h2_in;
   assign h3_out = d_in + h3_in;
   assign h4_out = e_in + h4_in;
   assign h5_out = f_in + h5_in;
   assign h6_out = g_in + h6_in;
   assign h7_out = h_in + h7_in;
   
endmodule
			  
module majority (input logic [31:0] x, y, z, output logic [31:0] maj);
	assign maj = (x & y) ^ (x & z) ^ (y & z);

endmodule // majority

module choice (input logic [31:0] x, y, z, output logic [31:0] ch);
	assign ch = (x & y) ^ (~x & z);

endmodule // choice

module Sigma0 (input logic [31:0] x, output logic [31:0] Sig0);
	assign Sig0 = ({x[1:0],x[31:2]}) ^ ({x[12:0], x[31:13]}) ^ ({x[21:0], x[31:22]});

endmodule // Sigma0

module sigma0 (input logic [31:0] x, output logic [31:0] sigma0);
	assign sigma0 = ({x[6:0],x[31:7]}) ^ ({x[17:0], x[31:18]}) ^ (x>>3);

endmodule // sigma0

module Sigma1 (input logic [31:0] x, output logic [31:0] Sig1);
	assign Sig1 = ({x[5:0],x[31:6]}) ^ ({x[10:0], x[31:11]}) ^ ({x[24:0], x[31:25]});

endmodule // Sigma1

module sigma1 (input logic [31:0] x, output logic [31:0] sigma1);
	assign sigma1 = ({x[16:0],x[31:17]}) ^ ({x[18:0], x[31:19]}) ^ (x>>10);

endmodule// sigma1

     
   


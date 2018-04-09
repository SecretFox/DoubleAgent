/**
 * ...
 * @author fox
 */
class com.fox.DoubleAgent.MissionIDs{
	public var SharedID:Array;
	public var TemplarID:Array;
	public var LumieID:Array;
	public var DragonID:Array;
	public var TemplarIDSpecial:Array;
	public var LumieIDSpecial:Array;
	public var DragonIDSpecial:Array;
	/*	datamined string categories 50303, 50310, 50311, 50312, 50314, 50315, 50316 respectively
	*   with notepad++ regex replace:
	*	1.replace '    "([0-9]+).*' with '$1,'
	*	2.remove '\r\n'
	*/	
	
	public function MissionIDs() {
		SharedID = new Array(12218,12219,12220,12221,12222,12223,12224,12245,12246,12255,12256,12257,12258,12281,12507,12508,12509,12510,12511,12520,13045,13046,13047,13071,13072,13073,13074,13334,13364,13366,13369,13414,13415,13416,13417,13418,13419,13420,13421,13422,13423,13424,13742,13745,13747,13777,13785,14577,14594,14615,14616,14617,14618,14619,14620,14622,14623,14624,14625,14633,14685,14686,14687,14688,14689,14703,14704,14705,14706,14707,14708,14709,14710,14711,14713,14745,14814,14818,14819,14840,14855,14856,14857,14858,14859,14860,14861,14862,14871,14872,14883,14884,14894,14899,14901,14913,14920,14925,14926,14927,14928,14930,14931,14932,14937,14938,14939,14940,14942,14944,14947,14957,14960,14980,14981,14982,14983,14984,15008,15018,15019,15020,15021,15022,15023,15024,15025,15030,15031,15032,15033,15045,15046,15047,15048,15049,15051,15053,15063,15064,15065,15066,15067,15068,15069,15070,15071,15072,15073,15076,15077,15079,15080,15083,15084,15085,15086,15092,15098,15099,15100,15101,15103,15104,15105,15106,15107,15109,15110,15116,15118,15119,15120,15125,15126,15127,15128,15129,15132,15133,15135,15136,15139,15142,15143,15144,15145,15147,15149,15150,15151,15152,15153,15154,15155,15156,15157,15158,15159,15160,15161,15162,15163,15164,15165,15166,15167,15168,15169,15170,15171,15172,15173,15174,15175,15185,15186,15188,15189,15191,15192,15193,15194,15195,15196,15197,15198,15199,15200,15201,15202,15203,15204,15209,15211,15213,15217,15220,15221,15230,15233,15237,15239,15242,15244,15246,15247,15249,15250,15253,15255,15257,15259,15266,15268,15269,15270,15271,15278,15279,15286,15287,15288,15308,15310,15311,15312,15313,15314,15315,15319,15320,15332,15334,15335,15336,15337,15338,15339,15349,15350,15351,15352,15353,15354,15355,15356,15358,15360,15361,15364,15368,15369,15370,15378,15397,15400,15401,15417,15418,15419,15420,15421,15422,15432,15451,15455,15456,15457,15458,15459,15460,15470,15471,15473,15474,15475,15476,15477,15480,15481,15482,15483,15489,15490,15491,15492,15493,15494,15495,15496,15497,15498,15499,15500,15503,15504,15505,15507,15508,15509,15512,15514,15516,15522,15528,15558,15560,15561,15562,15563,15564,15565,15566,15567,15572,15573,15574,15575,15576,15577,15578,15579,15580,15581,15582,15583,15584,15586,15587,15588,15589,15590,15594,15595,15596,15597,15598,15599,15600,15601,15602,15604,15605,15606,15607,15609,15610,15611,15612,15613,15614,15615,15616,15617,15618,15619,15620,15621,15622,15623,15624,15625,15626,15627,15628,15629,15630,15631,15632,15633,15644,15645,15646,15647,15648,15649,15650,15651,15652,15653,15654,15655,15656,15657,15658,15659,15661,15662,15665,15666,15667,15670,15673,15674,15675,15676,15680,15681,15682,15683,15684,15686,15688,15689,15690,15703,15704,15706,15707,15708,15709,15710,15711,15719,15723,15737,15738,15739,15741,15743,15744,15745,15750,15751,15752,15758,15759,15764,15767,15771,15772,15773,15774,15784,15786,15787,15788,15789,15791,15803,15804,15805,15806,15807,15808,15818,15819,15824,15825,15827,15846,15847,15849,15852,15853,15854,15855,15856,15868,15869,15873,15879,15881,15884,15885,15886,15897,15898,15899,15900,15901,15902,15903,15904,15905,15907,15911,15915,15917,15918,15919,15921,15923,15931,15936,15939,15940,15941,15942,15943,15945,15946,15948,15950,15952,15953,15954,15955,15956,15957,15960,15961,15962,15963,15969,15970,15972,15973,15985,15987,15988,15989,15990,15991,15992,15996,16015,16023,16025,16028,16029,16033,16039,16040,16041,16043,16046,16047,16048,16049,16051,16053,16056,16057,16061,16067,16069,16070,16071,16072,16073,16074,16077,16079,16080,16083,16095,16096,16101,16102,16103,16104,16105,16106,16107,16110,16111,16112,16124,16125,16127,16128,16129,16130,16133,16135,16136,16141,16143,16144,16145,16155,16159,16160,16161,16162,16166,16172,16175,16177,16178,16179,16180,16181,16182,16185,16186,16189,16190,16191,16194,16200,16201,16204,16205,16206,16207,16209,16211,16212,16213,16214,16215,16217,16219,16220,16221,16222,16223,16224,16225,16230,16231,16233,16234,16236,16238,16239,16240,16242,16249,16250,16251,16252,16253,16254,16255,16257,16258,16261,16262,16265,16266,16276,16286,16288,16293,16295,16296,16297,16298,16299,16301,16302,16303,16304,16305,16306,16308,16312,16313,16314,16315,16316,16317,16318,16319,16320,16322,16323,16324,16328,16329,16330,16331,16332,16334,16342,16343,16344,16345,16346,16353,16354,16355,16356,16358,16360,16361,16362,16363,16364,16365,16366,16367,16368,16369,16370,16371,16372,16373,16374,16375,16376,16377,16379,16382,16392,16393,16394,16395,16396,16397,16402,16403,16407,16408,16409,16410,16412,16425,16426,16430,16431,16432,16433,16435,16437,16438,16439,16440,16443,16444,16445,16446,16447,16449,16450,16451,16453,16455,16457,16458,16459,16460,16461,16462,16463,16464,16465,16466,16467,16468,16469,16470,16471,16472,16474,16475,16477,16478,16479,16483,16484,16488,16489,16490,16491,16492,16493,16496,16498,16499,16500,16501,16502,16503,16504,16505,16506,16507,16509,16510,16511,16512,16514,16518,16520,16521,16522,16524,16525,16526,16527,16531,16532,16533,16535,16536,16537,16538,16540,16541,16542,16543,16544,16546,16547,16549,16550,16551,16554,16555,16556,16557,16559,16565,16567,16571,16576,16577,16579,16586,16587,16588,16590,16591,16592,16595,16596,16597,16605,16606,16609,16610,16611,16612,16617,16618,16619,16620,16621,16622,16633,16634,16638,16639,16642,16656,16657,16659,16660,16662,16665,16671,16676,16677,16678,16681,16683,16684,16685,16686,16687,16688,16689,16690,16693,16694,16695,16696,16697,16699,16702,16703,16707,16721,16724,16725,16726,16727,16729,16732,16733,16734,16735,16736,16738,16742,16743,16744,16746,16747,16748,16749,16750,16752,16755,16758,16760,16762,16763,16764,16765,16766,16768,16770,16774,16775,16776,16777,16778,16786,16787,16788,16789,16790,16791,16798,16799,16800,16802,16803,16804,16805,16806,16807,16808,16809,16810,16811,16815,16817,16818,16820,16821,16822,16823,16828,16829,16830,16831,16832,16833,16837,16839,16847,16848,16854,16863,16864,16865,16866,16870,16871,16873,16874,16875,16876,16877,16878,16879,16881,16883,16884,16885,16886,16887,16888,16889,16890,16891,16892,16894,16896,16898,16899,16900,16901,16902,16904,16905,16907,16908,16909,16910,16911,16912,16913,16914,16915,16916,16918,16920,16922,16925,16926,16927,16928,16929,16931,16932,16933,16934,16935,16937,16938,16939,16940,16942,16945,16946,16947,16949,16950,16952,16953,16954,16955,16956,16957,16960,16961,16962,16963,16964,16965,16966,16968,16969,16970,16972,16973,16974,16975,16976,16977,16980,16982,16983,16985,16986,16987,16988,16989,16990,16991,16992,16993,16994,16995,16996,16998,16999,17002,17003,17030,17033,17034,17037,17038,17039,17040,17041,17042,17043,17045,17046,17047,17049,17059,17061,17063,17064,17076,17077,17078,17079,17080,17081,17082,17083,17084,17086,17088,17089,17090,17093,17094,17095,17096,17097,17098,17099,17101,17102,17103,17104,17105,17111,17113,17114,17115,17116,17117,17118,17119,17120,17121,17122,17123,17125,17126,17127,17128,17130,17131,17132,17140,17141,17142,17145,17146,17147,17148,17149,17150,17151,17154,17155,17156,17158,17159,17161,17163,17164,17169,17170,17171,17172,17173,17174,17175,17176,17178,17180,17181,17182,17183,17184,17185,17186,17187,17188,17189,17190,17191,17200,17201,17202,17204,17205,17206,17207,17208,17210,17214,17215,17216,17217,17219,17220,17222,17224,17225,17226,17227,17228,17229,17232,17233,17234,17235,17236,17240,17241,17242,17244,17245,17246,17250,17260,17262,17263,17264,17265,17266,17267,17268,17269,17270,17271,17272,17273,17274,17276,17278,17279,17280,17282,17284,17287,17288,17289,17290,17291,17296,17297,17300,17301,17302,17303,17305,17307,17308,17310,17311,17313,17314,17315,17316,17318,17321,17323,17324,17325,17327,17328,17329,17330,17331,17332,17333,17334,17339,17340,17341,17343,17344,17345,17346,17347,17348,17351,17352,17353,17354,17355,17361,17363,17365,17367,17368,17372,17373,17374,17375,17376,17377,17378,17379,17381,17382,17383,17384,17385,17386,17387,17388,17389,17390,17392,17393,17394,17395,17396,17397,17398,17400,17401,17402,17403,17404,17405,17406,17407,17409,17410,17411,17412,17413,17414,17416,17417,17418,17419,17420,17421,17422,17423,17424,17425,17426,17427,17429,17430,17431,17432,17433,17434,17435,17436,17439,17440,17441,17442,17444,17445,17446,17447,17448,17449,17451,17453,17455,17460,17461,17462,17463,17464,17468,17471,17472,17473,17474,17475,17477,17478,17479,17485,17486,17487,17488,17489,17490,17491,17492,17493,17494,17495,17496,17497,17499,17500,17501,17508,17509,17512,17513,17515,17516,17518,17519,17520,17522,17523,17524,17533,17534,17535,17542,17543,17544,17545,17547,17548,17549,17551,17553,17555,17556,17557,17558,17559,17560,17561,17562,17563,17566,17567,17568,17570,17572,17574,17579,17581,17582,17583,17584,17589,17590,17591,17592,17593,17594,17595,17596,17600,17601,17602,17606,17607,17610,17611,17612,17613,17614,17620,17621,17622,17624,17625,17626,17627,17628,17629,17630,17631,17632,17633,17634,17635,17636,17637,17638,17639,17640,17641,17642,17644,17645,17646,17647,17648,17649,17651,17656,17657,17658,17661,17666,17669,17670,17671,17672,17673,17674,17677,17678,17682,17683,17687,17688,17689,17690,17697,17704,17706,17707,17709,17710,17711,17712,17713,17714,17716,17717,17718,17720,17721,17722,17723,17724,17725,17726,17727,17728,17729,17730,17731,17732,17733,17734,17735,17736,17738,17739,17740,17741,17742,17743,17744,17745,17747,17748,17749,17750,17751,17752,17753,17754,17755,17756,17757,17758,17759,17760,17761,17763,17764,17766,17767,17773,17774,17775,17776,17777,17778,17779,17780,17781,17782,17783,17791,17792,17793,17794,17795,17796,17797,17798,17801,17802,17803,17804,17805,17806,17807,17808,17810,17811,17812,17813,17814,17815,17816,17817,17819,17823,17824,17825,17826,17827,17828,17829,17833,17834,17836,17837,17839,17840,17841,17842,17843,17845,17849,17851,17853,17855,17856,17857,17858,17859,17861,17863,17864,17865,17866,17867,17869,17871,17872,17874,17875,17876,17879,17880,17881,17882,17883,17885,17888,17891,17892,17894,17895,17896,17901,17902,17903,17904,17905,17906,17907,17908,17909,17911,17912,17913,17915,17916,17917,17918,17920,17922,17923,17925,17926,17927,17928,17929,17930,17932,17936,17937,17938,17939,17940,17941,17942,17943,17945,17947,17948,17951,17952,17953,17954,17956,17960,17961,17962,17965,17966,17967,17968,17972,17974,17976,17978,17980,17981,17982,17983,17984,17985,17986,17987,17988,17989,17990,17991,17992,17993,17994,17995,17996,17997,17998,17999,18000,18001,18002,18003,18004,18005,18006,18007,18008,18009,18010,18011,18012,18016,18017,18018,18019,18020,18021,18022,18023,18024,18025,18026,18027,18028,18029,18030,18031,18032,18033,18034,18035,18036,18037,18038,18039,18040,18041,18042,18043,18044,18045,18046,18047,18051,18052,18053,18054,18056,18057,18058,18059,18060,18061,18062,18063,18064,18065,18066,18067,18068,18070,18072,18073,18074,18075,18076,18077,18079,18080,18082,18083,18084,18085,18086,18087,18089,18091,18099,18101,18103,18105,18107,18109,18111,18112,18113,18114,18115,18116,18117,18118,18119,18122,18124,18125,18126,18127,18128,18129,18130,18132,18133,18134,18135,18136,18137,18138,18139,18140,18141,18145,18147,18148,18149,18150,18151,18152,18154,18155,18156,18157,18158,18159,18161,18162,18163,18164,18166,18167,18168,18169,18170,18171,18172,18173,18174,18175,18176,18179,18180,18181,18182,18183,18184,18185,18186,18187,18188,18190,18191,18192,18193,18194,18195,18196,18197,18198,18199,18200,18201,18204,18206,18207,18208,18209,18210,18211,18212,18213,18214,18215,18218,18219,18220,18223,18224,18225,18226,18227,18230,18231,18233,18235,18236,18237,18239,18240,18241,18242,18244,18247,18248,18249,18250,18251,18252,18255,18256,18257,18258,18264,18265,18266,18267,18270,18271,18272,18273,18274,18275,18276,18277,18279,18280,18281,18282,18283,18290,18291,18292,18293,18294,18297,18300,18301,18302,18303,18310,18312,18313,18314,18317,18320,18321,18323,18324,18325,18326,18327,18328,18329,18330,18332,18333,18335,18336,18337,18338,18339,18340,18341,18342,18343,18344,18345,18346,18347,18348,18349,18350,18351,18352,18353,18354,18355,18356,18357,18358,18360,18361,18362,18363,18364,18365,18366,18367,18368,18369,18370,18371,18372,18373,18375,18378,18379,18381,18382,18383,18384,18385,18386,18388,18389,18390,18391,18392,18395,18396,18399,18400,18401,18402,18403,18404,18405,18406,18408,18410,18411,18412,18414,18415,18416,18417,18418,18419,18420,18421,18422,18423,18424,18425,18426,18427,18428,18429,18430,18431,18432,18433,18434,18435,18436,18437,18440,18441,18442,18443,18445,18446,18449,18450,18451,18452,18453,18454,18455,18456,18457,18458,18459,18460,18463,18464,18465,18466,18467,18468,18469,18470,18472,18473,18474,18475,18476,18478,18480,18481,18482,18483,18484,18486,18487,18489,18491,18492,18493,18494,18495,18496,18497,18498,18499,18500,18502,18503,18504,18505,18506,18508,18509,18510,18511,18512,18513,18514,18515,18516,18517,18518,18519,18520,18521,18522,18524,18525,18526,18527,18528,18529,18530,18531,18532,18533,18534,18535,18536,18538,18541,18542,18543,18544,18545,18546,18547,18548,18549,18550,18552,18554,18555,18556,18557,18558,18559,18560,18561,18562,18563,18564,18565,18566,18567,18568,18569,18570,18571,18572,18574,18575,18577,18578,18579,18580,18583,18584,18585,18586,18587,18588,18589,18590,18591,18592,18593,18594,18595,18596,18597,18598,18599,18600,18601,18602,18603,18604,18605,18606,18607,18608,18609,18610,18611,18612,18613,18614,18615,18616,18617,18618,18619,18620,18621,18622,18623,18624,18625,18626,18630,18631,18632,18633,18634,18635,18636,18637,18638,18639,18640,18643,18644,18645,18646,18647,18648,18650,18653,18654,18655,18656,18657,18658,18659,18660,18661,18662,18664,18665,18666,18667,18669,18670,18671,18672,18673,18674,18675,18676,18677,18678,18680,18685,18686,18687,18688,18695,18697,18698,18699,18700,18701,18702,18703,18704,18705,18706,18707,18710,18711,18712,18713,18714,18715,18716,18717,18718,18719,18720,18721,18722,18723,18724,18725,18726,18727,18728,18729,18730,18731,18732,18735,18737,18738,18739,18740,18741,18742,18743,18744,18745,18746,18747,18748,18749,18750,18751,18752,18753,18755,18756,18757,18758,18759,18760,18762,18763,18764,18766,18767,18768,18769,18772,18776,18778,18779,18780,18781,18783,18785,18787,18788,18789,18790,18792,18794,18795,18796,18797,18798,18799,18802,18803,18804,18805,18807,18808,18809,18810,18811,18813,18814,18815,18816,18817,18818,18819,18820,18821,18822,18823,18824,18825,18826,18827,18829,18830,18831,18832,18833,18834,18835,18836,18837,18838,18839,18840,18841,18842,18843,18844,18845,18846,18847,18848,18850,18851,18852,18853,18855,18856,18857,18863,18864,18865,18866,18867,18868,18869,18871,18872,18873,18874,18875,18876,18877,18878,18880,18881,18882,18883,18884,18885,18887,18888,18889,18890,18891,18892,18893,18894,18895,18896,18897,18898,18899,18900,18901,18902,18903,18904,18905,18906,18907,18908,18909,18910,18911,18912,18913,18914,18915,18916,18917,18918,18919,18920,18921,18922,18923,18924,18925,18926,18927,18928,18929,18930,18931,18932,18933,18934,18935,18936,18937,18938,18939,18940,18941,18942,18943,18944,18945,18946,18947,18948,18951,18952,18955,18956,18959,18964,18965,18966,18967,18968,18969,18970,18971,18972,18974,18975,18976,18977,18978,18979,18980,18981,18982,18983,18984,18985,18986,18987,18988,18989,18990,18991,18992,18993,18994,18998,18999,19000,19001,19002,19003,19004,19005,19006,19007,19008,19009,19010,19011,19012,19013,19022,19023,19024,19025,19026,19028,19029,19030,19031,19032,19033,19034,19035,19036,19037,19042,19043,19044,19046,19047,19048,19049,19050,19051,19052,19053,19055,19056,19057,19058,19059,19060,19062,19063,19064,19065,19066,19067,19068,19069,19070,19071,19072,19075,19077,19082,19083,19084,19086,19087,19088,19089,19099,19103,19104,19105,19106,19107,19109,19110,19111,19112,19116,19117,19118,19119,19120,19121,19122,19123,19124,19125,19126,19129,19130,19134,19137,19149,19150,19151,19152,19153,19154,19155,19156,19157,19158,19159,19160,19161,19162,19163,19164,19165,19166,19167,19168,19169,19170,19171,19172,19173,19174,19175,19176,19177,19178,19179,19180,19181,19182,19183,19184,19185,19186,19187,19191,19192,19194,19195,19196,19198,19199,19200,19201,19202,19203,19204,19205,19206,19207,19208,19209,19210,19211,19212,19213,19214,19215,19216,19217,19218,19230,19232,19243,19244,19261,19262,19263,19264,19265,19266,19267,19268,19269,19270,19271,19272,19273,19274,19275,19276,19277,19279,19280,19282,19285,19286,19287,19288,19289,19291,19292,19293,19294,19295,19296,19297,19298,19299,19300,19301,19302,19303,19304,19305,19306,19308,19309,19310,19311,19313,19314,19315,19316,19317,19318,19319,19320,19321,19322,19323,19324,19325,19326,19328,19329,19330,19331,19332,19333,19337,19341,19342,19347,19348,19349,19350,19351,19352,19353,19356,19357,19359,19361,19362,19363,19367,19369,19370,19371,19372,19374,19375,19376,19377,19378,19379,19382,19383,19384,19385,19388,19389,19390,19391,19392,19393,19394,19395,19396,19397,19398,19399,19400,19402,19403,19404,19405,19406,19407,19408,19409,19410,19411,19412,19413,19414,19415,19418,19419,19420,19421,19422,19423,19424,19425,19426,19431,19432,19433,19434,19435,19436,19438,19439,19447,19448,19449,19450,19451,19452,19453,19454,19455,19456,19457,19458,19459,19461,19462,19463,19464,19465,19466,19467,19468,19469,19470,19471,19472,19473,19474,19475,19476,19477,19478,19479,19480,19481,19482,19483,19484,19488,19489,19490,19492,19493,19494,19495,19497,19498,19499,19501,19502,19503,19504,19505,19506,19507,19508,19509,19513,19518,19519,19520,19521,19522,19523,19524,19525,19527,19528,19530,19532,19533,19534,19535,19536,19537,19538,19539,19540,19541,19542,19543,19544,19546,19547,19548,19549,19550,19551,19552,19553,19554,19555,19556,19557,19558,19559,19560,19561,19562,19563,19564,19565,19566,19567,19568,19569,19570,19571,19572,19573,19575,19576,19577,19578,19579,19581,19582,19583,19584,19585,19586,19587,19588,19590,19591,19592,19594,19595,19597,19598,19599,19600,19601,19603,19604,19606,19609,19611,19612,19615,19616,19617,19618,19619,19620,19621,19622,19623,19624,19625,19631,19632,19633,19634,19635,19636,19638,19639,19640,19641,19642,19643,19644,19645,19646,19647,19648,19649,19650,19651,19652,19653,19654,19656,19657,19658,19659,19660,19661,19662,19663,19664,19665,19666,19667,19668,19669,19670,19671,19672,19673,19674,19675,19676,19677,19679,19680,19686,19687,19688,19689,19690,19691,19692,19693,19707,19708,19709,19710,19711,19712,19713,19714,19715,19716,19717,19718,19719,19720,19721,19722,19723,19724,19725,19726,19727,19728,19729,19730,19731,19733,19734,19735,19736,19738,19739,19740,19742,19743,19744,19745,19746,19747,19749,19754,19755,19766,19771,19772,19786,19787,19788,19804,19805,19806,19807,19808,19810,19811,19812,19815,19816,19817,19818,19819,19820,19822,19823,19825,19826,19827,19828,19829,19830,19831,19832,19833,19834,19835,19836,19837,19838,19839,19840,19841,19842,19843,19845,19847,19848,19849,19850,19851,19852,19853,19854,19855,19856,19857,19858,19859,19860,19861,19862,19863,19864,19865,19866,19867,19869,19870,19871,19872,19873,19874,19875,19884,19885,19886,19889,19890,19891,19892,19893,19894,19895,19896,19898,19899,19900,19902,19903,19904,19906,19907,19908,19909,19921,19923,19924,19925,19926,19927,19928,19929,19930,19931,19933,19934,19935,19937,19938,19939,19940,19941,19942,19943,19944,19945,19946,19947,19948,19949,19950,19951,19952,19953,19954,19955,19956,19963,19964,19965,19966,19967,19968,19969,19970,19971,19972,19973,19974,19975,19976,19977,19979,19980,19981,19983,19985,19986,19987,19988,19989,19990,19992,19993,19994,19995,19996,19997,19998,19999,20000,20001,20002,20003,20004,20005,20006,20007,20008,20009,20010,20011,20012,20013,20014,20015,20019,20020,20021,20022,20023,20025,20028,20031,20032,20033,20036,20037,20038,20039,20041,20042,20043,20044,20045,20046,20047,20050,20051,20052,20053,20054,20055,20056,20057,20058,20059,20060,20061,20062,20063,20064,20065,20066,20067,20068,20069,20070,20071,20072,20073,20074,20075,20076,20077,20078,20080,20081,20082,20083,20084,20085,20086,20087,20088,20089,20090,20091,20092,20094,20095,20096,20097,20098,20099,20100,20101,20102,20103,20104,20105,20106,20107,20108,20109,20110,20111,20112,20113,20114,20118,20120,20125,20127,20129,20130,20136,20137,20138,20139,20140,20142,20143,20144,20147,20149,20150,20151,20152,20153,20154,20155,20156,20157,20158,20160,20161,20162,20163,20164,20165,20166,20168,20169,20170,20171,20172,20177,20178,20179,20180,20181,20182,20183,20184,20185,20186,20187,20188,20189,20190,20195,20196,20197,20198,20199,20200,20201,20202,20203,20204,20205,20207,20208,20209,20211,20212,20213,20215,20216,20218,20220,20221,20222,20224,20225,20226,20227,20230,20231,20232,20233,20234,20236,20237,20239,20241,20242,20245,20246,20249,20250,20251,20252,20253,20255,20256,20257,20258,20259,20260,20261,20262,20263,20264,20265,20266,20267,20268,20269,20270,20271,20272,20273,20274,20275,20276,20277,20278,20279,20280,20281,20282,20283,20284,20285,20286,20287,20288,20289,20290,20291,20292,20293,20294,20296,20297,20298,20305,20306,20307,20308,20309,20310,20312,20313,20314,20315,20316,20317,20318,20319,20320,20321,20322,20323,20324,20325,20326,20327,20328,20329,20330,20331,20332,20333,20334,20336,20337,20338,20339,20344,20346,20348,20349,20351,20352,20353,20354,20355,20356,20357,20359,20360,20361,20362,20365,20369,20370,20371,20372,20373,20374,20375,20376,20377,20378,20379,20380,20381,20382,20383,20384,20385,20386,20387,20388,20389,20390,20391,20392,20393,20394,20395,20396,20397,20398,20399,20400,20403,20404,20407,20408,20409,20413,20414,20415,20416,20417,20418,20419,20421,20422,20423,20424,20426,20427,20428,20429,20431,20432,20433,20434,20435,20436,20437,20438,20439,20440,20441,20442,20443,20444,20445,20446,20447,20448,20449,20450,20452,20453,20454,20455,20457,20458,20459,20460,20461,20462,20463,20464,20465,20480,20481,20483,20484,20485,20486,20487,20489,20490,20492,20493,20501,20502,20503,20504,20505,20507,20508,20509,20510,20511,20513,20514,20515,20516,20517,20518,20519,20520,20521,20522,20523,20524,20525,20526,20527,20528,20529,20530,20531,20532,20533,20534,20535,20536,20537,20538,20540,20541,20542,20570,20571,20572,20573,20574,20575,20576,20577,20578,20579,20580,20581,20582,20583,20584,20585,20586,20587,20588,20589,20590,20591,20592,20593,20594,20595,20596,20597,20598,20599,20600,20601,20602,20603,20604,20605,20606,20607,20608,20609,20610,20611,20612,20613,20617,20618,20619,20620,20621,20622,20623,20624,20625,20626,20627,20629,20630,20631,20632,20634,20655,20656,20657,20658,20659,20660,20661,20662,20663,20664,20665,20666,20667,20668,20669,20670,20671,20672,20673,20674,20675,20676,20677,20678,20679,20680,20681,20682,20683,20684,20685,20686,20687,20688,20689,20690,20692,20693,20694,20695,20696,20697,20698,20699,20700,20701,20702,20703,20704,20705,20706,20715,20716,20717,20718,20719,20720,20721,20722,20723,20724,20725,20726,20728,20729,20730,20731,20732,20733,20734,20735,20736,20737,20738,20739,20740,20741,20742,20745,20746,20749,20750,20751,20752,20753,20754,20755,20756,20757,20758,20759,20760,20762,20763,20764,20765,20766,20767,20768,20769,20770,20771,20772,20773,20774,20775,20776,20777,20778,20779,20780,20781,20782,20783,20785,20786,20787,20788,20791,20792,20793,20794,20795,20796,20797,20798,20799,20800,20801,20802,20803,20804,20805,20806,20807,20808,20809,20810,20811,20812,20813,20814,20815,20816,20817,20818,20819,20820,20821,20822,20823,20824,20825,20826,20827,20828,20829,20830,20831,20832,20833,20834,20835,20836,20837,20838,20839,20840,20841,20842,20843,20844,20845,20846,20847,20848,20849,20850,20851,20852,20853,20854,20856,20857,20858,20859,20860,20861,20862,20863,20864,20865,20866,20867,20878,20879,20880,20881,20882,20883,20884,20885,20886,20887,20888,20890,20891,20892,20893,20894,20895,20896,20897,20898,20899,20900,20901,20902,20903,20904,20905,20908,20909,20910,20917,20919,20921,20922,20923,20924,20925,20926,20927,20929,20930,20931,20932,20944,20945,20946,20949,20950,20953,20954,20955,20956,20957,20959,20961,20963,20965,20967,20969,20971,20973,20975,20977,20978,20979,20980,20981,20982,20983,20984,20985,20986,20987,20988,20989,20990,20991,20992,20993,20994,20995,20996,20997,20998,20999,21000,21001,21002,21003,21004,21005,21006,21007,21008,21009,21010,21012,21013,21014,21015,21016,21017,21018,21019,21020,21021,21022,21023,21024,21025,21026,21027,21028,21029,21030,21031,21032,21034,21035,21036,21037,21039,21040,21041,21042,21043,21044,21055,21056,21057,21058,21059,21060,21061,21062,21063,21064,21065,21066,21067,21068,21069,21070,21071,21072,21073,21074,21075,21076,21077,21078,21079,21081,21083,21084,21086,21087,21089,21091,21093,21095,21097,21100,21101,21102,21103,21104,21106,21107,21108,21110,21111,21113,21114,21115,21116,21117,21118,21119,21120,21121,21122,21123,21124,21125,21126,21127,21128,21130,21131,21132,21133,21134,21135,21136,21137,21144,21145,21146,21147,21148,21149,21150,21151,21152,21153,21154,21155,21156,21157,21158,21159,21160,21161,21163,21166,21168,21170,21172,21174,21176,21177,21178,21180,21181,21182,21183,21185,21186,21187,21188,21189,21190,21191,21192,21193,21194,21195,21196,21197,21198,21203,21204,21205,21206,21207,21208,21209,21210,21211,21212,21213,21214,21215,21216,21217,21218,21219,21220,21221,21222,21223,21224,21225,21226,21230,21233,21235,21236,21237,21238,21239,21240,21241,21242,21243,21244,21245,21246,21247,21248,21249,21250,21251,21252,21253,21254,21255,21256,21257,21258,21259,21260,21261,21264,21265,21266,21267,21268,21269,21270,21271,21272,21273,21274,21276,21277,21278,21279,21280,21281,21282,21283,21284,21285,21286,21287,21288,21289,21290,21291,21292,21293,21294,21295,21296,21297,21298,21299,21302,21303,21304,21305,21306,21307,21308,21309,21310,21312,21314,21315,21316,21317,21318,21319,21320,21321,21322,21323,21324,21325,21326,21327,21328,21329,21330,21331,21332,21333,21334,21336,21337,21338,21339,21340,21341,21342,21343,21344,21345,21348,21349,21350,21351,21352,21354,21355,21356,21357,21358,21359,21360,21361,21362,21363,21364,21365,21368,21369,21370,21371,21372,21373,21374,21375,21376,21377,21378,21379,21380,21381,21382,21385,21386,21387,21388,21389,21390,21391,21392,21393,21394,21395,21397,21398,21399,21400,21401,21402,21403,21404,21405,21406,21407,21410,21411,21412,21413,21414,21415,21417,21418,21419,21420,21421,21422,21423,21424,21425,21428,21429,21430,21431,21432,21433,21434,21436,21437,21438,21439,21440,21443,21444,21445,21446,21447,21448,21449,21451,21452,21453,21454,21456,21457,21458,21459,21460,21461,21462,21463,21464,21465,21466,21467,21469,21470,21471,21473,21474,21475,21476,21477,21478,21479,21480,21481,21482,21483,21484,21485,21486,21487,21488,21489,21490,21491,21493,21494,21496,21497,21498,21499,21500,21501,21502,21503,21504,21505,21506,21507,21508)
		TemplarID = new Array(15401,15422,15492,15494,15496,15500,15563,15567,15577,15583,15598,15607,15613,15633,15648,15658,15674,15774,15791,15853,15854,15855,15885,15911,15996,16005,16023,16043,16069,16077,16123,16131,16136,16141,16262,16334,16357,16365,16373,16393,16397,16410,16441,16442,16485,16507,16508,16514,16518,16522,16528,16534,16579,16597,16606,16660,16685,16704,16748,16833,16847,16849,16865,16883,16913,16941,16955,16996,16998,17030,17102,17118,17127,17142,17174,17178,17191,17200,17220,17223,17230,17246,17251,17272,17274,17290,17291,17299,17309,17311,17317,17349,17352,17354,17363,17370,17371,17376,17382,17391,17422,17428,17447,17452,17473,17480,17495,17498,17502,17513,17555,17557,17574,17596,17603,17610,17643,17659,17675,17685,17705,17767,17783,17798,17809,17811,17813,17816,17823,17829,17846,17864,17866,17870,17878,17892,17932,18071,18082,18087,18088,18131,18134,18138,18152,18156,18177,18197,18204,18212,18232,18236,18242,18244,18272,18282,18310,18312,18321,18322,18329,18336,18345,18358,18367,18368,18380,18394,18401,18406,18444,18446,18465,18467,18477,18478,18485,18487,18494,18497,18499,18505,18516,18522,18538,18541,18560,18564,18569,18571,18583,18586,18620,18651,18667,18669,18695,18699,18716,18728,18760,18763,18774,18777,18784,18802,18813,18828,18837,18846,18866,18871,18878,18881,18884,18892,18910,18917,18948,18951,18952,18997,19001,19013,19019,19112,19120,19126,19154,19163,19171,19180,19183,19185,19203,19204,19206,19207,19212,19214,19216,19217,19218,19230,19266,19268,19276,19277,19278,19279,19284,19285,19303,19304,19305,19315,19321,19323,19332,19333,19337,19342,19350,19362,19367,19379,19385,19397,19398,19399,19402,19403,19404,19405,19414,19436,19448,19455,19456,19466,19475,19479,19489,19498,19532,19537,19551,19555,19565,19570,19577,19584,19586,19590,19591,19592,19601,19604,19618,19623,19624,19631,19636,19639,19663,19676,19679,19688,19690,19691,19693,19707,19708,19709,19710,19711,19712,19713,19714,19715,19716,19719,19720,19721,19740,19749,19766,19771,19772,19786,19787,19788,19804,19805,19811,19812,19817,19823,19831,19849,19857,19858,19859,19861,19862,19863,19866,19870,19873,19896,19899,19900,19902,19903,19904,19907,19909,19921,19931,19941,19942,19943,19946,19956,19967,19970,19974,19976,19977,19985,19988,19995,20000,20014,20022,20031,20047,20051,20053,20056,20059,20064,20069,20070,20090,20094,20099,20103,20105,20130,20140,20145,20146,20147,20150,20152,20155,20156,20158,20160,20162,20164,20166,20168,20170,20186,20205,20246,20255,20262,20269,20270,20275,20308,20321,20330,20351,20371,20377,20383,20386,20389,20395,20404,20421,20426,20430,20433,20437,20440,20447,20448,20455,20464,20487,20491,20505,20511,20519,20522,20538,20542,20570,20574,20621,20625,20629,20632,20680,20683,20684,20695,20698,20742,20754,20760,20770,20775,20777,20778,20779,20795,20812,20826,20848,20851,20852,20886,20899,20900,20901,20903,20927,21026,21027,21059,21060,21061,21062,21063,21064,21065,21066,21067,21068,21069,21070,21084,21109,21151,21291,21292,21310,21320,21345,21350,21352,21356,21359,21362,21365,21367,21370,21372,21374,21383,21384,21396,21398,21415,21426,21430,21444,21445,21446,21449,21452,21453,21461,21468,21469,21471,21474,21477,21479,21483,21486,21487,21488,21489,21494,21498,21503)
		LumieID = new Array(15401,15422,15492,15494,15496,15500,15563,15567,15577,15583,15598,15607,15613,15633,15648,15658,15674,15774,15791,15853,15854,15855,15885,15911,15996,16005,16023,16043,16069,16077,16123,16131,16136,16141,16262,16334,16357,16365,16373,16393,16397,16410,16441,16442,16485,16507,16508,16514,16518,16522,16528,16534,16579,16597,16606,16660,16685,16704,16748,16833,16847,16849,16865,16883,16913,16941,16955,16996,16998,17030,17102,17118,17127,17142,17174,17178,17191,17200,17220,17223,17230,17246,17251,17272,17274,17290,17291,17299,17309,17311,17317,17349,17352,17354,17363,17370,17371,17376,17382,17391,17422,17428,17447,17452,17473,17480,17495,17498,17502,17513,17555,17557,17574,17596,17603,17610,17643,17659,17675,17685,17705,17767,17783,17798,17809,17811,17813,17816,17823,17829,17846,17864,17866,17870,17878,17892,17932,18071,18082,18087,18088,18131,18134,18138,18152,18156,18177,18197,18204,18212,18232,18236,18242,18244,18272,18282,18310,18312,18321,18322,18329,18336,18345,18358,18367,18368,18380,18394,18401,18406,18444,18446,18465,18467,18477,18478,18485,18487,18494,18497,18499,18505,18516,18522,18538,18541,18560,18564,18569,18571,18583,18586,18620,18651,18667,18669,18695,18699,18716,18728,18760,18763,18774,18777,18784,18802,18813,18828,18837,18846,18866,18871,18878,18881,18884,18892,18910,18917,18948,18951,18952,18997,19001,19013,19019,19112,19120,19126,19154,19163,19171,19180,19183,19185,19203,19204,19206,19207,19212,19214,19216,19217,19218,19230,19266,19268,19276,19277,19278,19279,19284,19285,19303,19304,19305,19315,19321,19323,19332,19333,19337,19342,19350,19362,19367,19379,19385,19397,19398,19399,19402,19403,19404,19405,19414,19436,19448,19455,19456,19466,19475,19479,19489,19498,19532,19537,19551,19555,19565,19570,19577,19584,19586,19590,19591,19592,19601,19604,19618,19623,19624,19631,19636,19639,19663,19676,19679,19688,19690,19691,19693,19707,19708,19709,19710,19711,19712,19713,19714,19715,19716,19719,19720,19721,19740,19749,19766,19771,19772,19786,19787,19788,19804,19805,19811,19812,19817,19823,19831,19849,19857,19858,19859,19861,19862,19863,19866,19870,19873,19896,19899,19900,19902,19903,19904,19907,19909,19921,19931,19941,19942,19943,19946,19956,19967,19970,19974,19976,19977,19985,19988,19995,20000,20014,20022,20031,20047,20051,20053,20056,20059,20064,20069,20070,20090,20094,20099,20103,20105,20130,20140,20145,20146,20147,20150,20152,20155,20156,20158,20160,20162,20164,20166,20168,20170,20186,20205,20246,20255,20262,20269,20270,20275,20308,20321,20330,20351,20371,20377,20383,20386,20389,20395,20404,20421,20426,20430,20433,20437,20440,20447,20448,20455,20464,20487,20491,20505,20511,20519,20522,20538,20542,20570,20574,20621,20625,20629,20632,20680,20683,20684,20695,20698,20742,20754,20760,20770,20775,20777,20778,20779,20795,20812,20826,20848,20851,20852,20886,20899,20900,20901,20903,20927,21026,21027,21059,21060,21061,21062,21063,21064,21065,21066,21067,21068,21069,21070,21084,21109,21151,21291,21292,21310,21320,21345,21350,21352,21356,21359,21362,21365,21367,21370,21372,21374,21383,21384,21396,21398,21415,21426,21430,21444,21445,21446,21449,21452,21453,21461,21468,21469,21471,21474,21477,21479,21483,21486,21487,21488,21489,21494,21498,21503)
		DragonID = new Array(15401,15422,15492,15494,15496,15500,15563,15567,15577,15583,15598,15607,15613,15633,15648,15658,15674,15774,15791,15853,15854,15855,15885,15911,15996,16005,16023,16043,16069,16077,16123,16131,16136,16141,16262,16334,16357,16365,16373,16393,16397,16410,16441,16442,16485,16507,16508,16514,16518,16522,16528,16534,16579,16597,16606,16660,16685,16704,16748,16833,16847,16849,16865,16883,16913,16941,16955,16996,16998,17030,17102,17118,17127,17142,17174,17178,17191,17200,17220,17223,17230,17246,17251,17272,17274,17290,17291,17299,17309,17311,17317,17349,17352,17354,17363,17370,17371,17376,17382,17391,17422,17428,17447,17452,17473,17480,17495,17498,17502,17513,17555,17557,17574,17596,17603,17610,17643,17659,17675,17685,17705,17767,17783,17798,17809,17811,17813,17816,17823,17829,17846,17864,17866,17870,17878,17892,17932,18071,18082,18087,18088,18131,18134,18138,18152,18156,18177,18197,18204,18212,18232,18236,18242,18244,18272,18282,18310,18312,18321,18322,18329,18336,18345,18358,18367,18368,18380,18394,18401,18406,18444,18446,18465,18467,18477,18478,18485,18487,18494,18497,18499,18505,18516,18522,18538,18541,18560,18564,18569,18571,18583,18586,18620,18651,18667,18669,18695,18699,18716,18728,18760,18763,18774,18777,18784,18802,18813,18828,18837,18846,18866,18871,18878,18881,18884,18892,18910,18917,18948,18951,18952,18997,19001,19013,19019,19112,19120,19126,19154,19163,19171,19180,19183,19185,19203,19204,19206,19207,19212,19214,19216,19217,19218,19230,19266,19268,19276,19277,19278,19279,19284,19285,19303,19304,19305,19315,19321,19323,19332,19333,19337,19342,19350,19362,19367,19379,19385,19397,19398,19399,19402,19403,19404,19405,19414,19436,19448,19455,19456,19466,19475,19479,19489,19498,19532,19537,19551,19555,19565,19570,19577,19584,19586,19590,19591,19592,19601,19604,19618,19623,19624,19631,19636,19639,19663,19676,19679,19688,19690,19691,19693,19707,19708,19709,19710,19711,19712,19713,19714,19715,19716,19719,19720,19721,19740,19749,19766,19771,19772,19786,19787,19788,19804,19805,19811,19812,19817,19823,19831,19849,19857,19858,19859,19861,19862,19863,19866,19870,19873,19896,19899,19900,19902,19903,19904,19907,19909,19921,19931,19941,19942,19943,19946,19956,19967,19970,19974,19976,19977,19985,19988,19995,20000,20014,20022,20031,20047,20051,20053,20056,20059,20064,20069,20070,20090,20094,20099,20103,20105,20130,20140,20145,20146,20147,20150,20152,20155,20156,20158,20160,20162,20164,20166,20168,20170,20186,20205,20246,20255,20262,20269,20270,20275,20308,20321,20330,20351,20371,20377,20383,20386,20389,20395,20404,20421,20426,20430,20433,20437,20440,20447,20448,20455,20464,20487,20491,20505,20511,20519,20522,20538,20542,20570,20574,20621,20625,20629,20632,20680,20683,20684,20695,20698,20742,20754,20760,20770,20775,20777,20778,20779,20795,20812,20826,20848,20851,20852,20886,20899,20900,20901,20903,20927,21026,21027,21059,21060,21061,21062,21063,21064,21065,21066,21067,21068,21069,21070,21084,21109,21151,21291,21292,21310,21320,21345,21350,21352,21356,21359,21362,21365,21367,21370,21372,21374,21383,21384,21396,21398,21415,21426,21430,21444,21445,21446,21449,21452,21453,21461,21468,21469,21471,21474,21477,21479,21483,21486,21487,21488,21489,21494,21498,21503)
	
		TemplarIDSpecial = new Array(21415,21430,21444,21468,21469,21471,21474,21477,21479,21483,21486,21487,21488,21489,21494,21498,21503)
		LumieIDSpecial = new Array(21415,21430,21444,21468,21469,21471,21474,21477,21479,21483,21486,21487,21488,21489,21494,21498,21503)
		DragonIDSpecial = new Array(21415,21430,21444,21468,21469,21471,21474,21477,21479,21483,21486,21487,21488,21489,21494,21498,21503)
		
		
	}
	
}
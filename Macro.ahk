; huge thanks to:
; raynnpjl for contributing the card selector
; yuh for heavily inspiring  the macro + some functions
; taxi for the base macro

#Requires AutoHotkey v2.0
#Include %A_ScriptDir%\Lib\gui.ahk
#Include %A_ScriptDir%\Lib\config.ahk
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\imageForCS.ahk
#Include %A_ScriptDir%\Lib\OCR-main\Lib\OCR.ahk
#Include %A_ScriptDir%\Lib\WebhookOptions.ahk
#Include %A_ScriptDir%\Lib\keybinds.ahk
#Include %A_ScriptDir%\Lib\IsProcessElevated.ahk
#Include %A_ScriptDir%\Lib\updates.ahk
#Include %A_ScriptDir%\Lib\Maps.ahk

global MacroStartTime := A_TickCount
global StageStartTime := A_TickCount

SendMode "Event"
RobloxWindow := "ahk_exe RobloxPlayerBeta.exe"
UnitExistence := "|<>*91$66.btzzzzzzyDzXlzzzzzzyDzXlzzzzzzyDzXlzzzyzzyDbXlUS0UM3UC1XlUA0UE30A1XlW4EXl34AMXlX0sbXXC80XVX4MbXX6A1U3UA0bk30ARk7UC0bk3UA1sDUz8bw3kC1zzbyszzzzzzzzbw1zzzzzzzzby3zzzzzzzzzzjzzzzzzU"
MaxUpgrade := "|<>*134$53.0000000007U3k00000TUDk00001XUsk000033XVU0000636300800A3M6TzwS0M3UDrjRa0k70S0AS61U40s0EMAD001U0k0Ty41331k1zwA6673k7zsQAAS7UTzkwsMQC0TzVzkk0M0Tz3zVk0kETy7z3k1VkzwTz7kX7nzzzzzzzzzzzzzzzzzzw"
MaxUpgrade2 := "|<>*146$47.D07U0001z0Tk000371lU00067z3zzzzw7w7zzzzs7kDzzzzk7UTzSzzUC0w0MwD081k0UkS00301U1w82663U3sMAAC7UDkssMwD0zVvkksQ0z3zVU0k0y7z3U1UUwDy7U33VszyDX6Dbzzzzzzzzzzzzzzzy"
MaxUpgrade3 := "|<>*91$49.Dk7s00004M3600006633000031X1U0001UP0nzr3kkD0PzynAM3UD06D3A0U70331a00301U1X20VVUs1lVUklsS1kkssMwD0kMSQAC70AA/u603036413U1UUn20Vs0ksNX0My4NqMTUDnzzlwU"
VoteStart := "|<>*95$38.ryzzzzlz7zlzwDVzwTzXszz7zsSC30Q7770E40klU410C8sklVXUACAM0w7X360T1s1kEbsz0Q40zDsTVUM"
LobbyText := "|<>*134$56.0000000000k00U10000T00y1w000Cs0RkvU003606AAM000lU1X36000AMzMwlswS36zyDwTzjslw7WD4ST6AS0M1k33lX7060A0MMPlkkVX366DwQS8sFkk3z772C4QC1zlkkV327UTw40M0k1wDz1UC0Q0z3zsQ7WD4TkzzzzzzzzwTzzzzzzzy7zzzzzzzzXzzzzzzzzszs"
AreasText := "|<>*108$36.zs007zyzztzzwTzzzzwTzTzzsA4613tA421/k4M0F3k4M4FXXUQ603bmy713zzzzzzU"
MatchmakeUI := "|<>*129$83.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUzzzzzzzzzzzzz0zzzzzzzw7zzzw1zzzzzzzkDzzzs3zzzzzzzUTzzzs7zzzzzzz0zzzzkTzzzzzzy1zzzzzzzzzzzzw3zzzzzzzzzzzzs7zzzzzzzzzzzzkDy0Tw7UsDzzzzUTk0Ds7007zzzz0z00DUA007zzzy1w00D0M007zzzw3k00S0k00Dzzzs7U00Q1U00DzzzkC0S0s3060TzzzUQ1y0k60y0zzzz0s7w1UA1y1zzzy1kDs30M3w3zzzw3UTk60k7s7zy7k70TUA1UDkDzs70C0Q0s30TUTzk00S001k60z0zzU01w007UA1y1zz007w00D0M3w3zz00Dw00y0k7s7zz01zw03y1kDkDzzU7zy0Tw7UzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"
CaptchaExistence := "|<>*100$131.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzzzzzs3zzzzzzzzzzzkDzzzzzzz01zzzzzzy7zzzUTzzzzzzs00zzzzzzs7zzz0zzzzzzzU01zzzzzzkDzzy1zzzzzzy003zzzzzzUTzzw3zzzzzzs007zzzzzz0zzzs7zzzzzzk7wTzzzzzy1zyTkDzzzzzz0Tzz0UsEDk0DU7UEDz0Uzy1zzw01U0DU0S0300Dw01zw3zzk0300C00s0600Dk03zsDzz00600C01U0A00T007zkTzw00A00A0200M00Q00DzUzzs30M3US1w1lk70s30Tz0zzkD0kDUw3s7zUT1kD0zy1zzUz1UT1s7kTz0y3Uz1zw1zz1w30y3kDUzy1w31w3zw1zC1s61s7UT0zw3s61s7zs0sA00A00D0y0Es7kA00Dzs00A00M00y0C00kDUQ00Tzs00M00k01y0A01UT0s00zzs00s01U07w0Q030y3s01zzs03s0300zw1w0C1w7s03zzw0TwCC1rzy3y1y7wDwCDzzzzzzzw3zzzzzzzzzzzzzzzzzzzzs7zzzzzzzzzzzzzzzzzzzzkDzzzzzzzzzzzzzzzzzzzzUTzzzzzzzzzzzzzzzzzzzz0zzzzzzzzzzzzzzzzzzzzy3zzzzzzzzzzzzzzzzzzzzy7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"
Matchmaking := "|<>*93$73.zzzzzzzzzzzzzzlzzzsszzzzk08zzzwATzzzs04Tzzy6Dzzzw03zzzz3zzzzy7zzzzzVzzzzz3zX4DwElW7w8U7lU3s0Mk1w0E1sk0w0AM0Q080wM0A06A06040SAC6736737W7z6D37VX3VXl3zX7VVklXkkkVzlXkk0MlsM0EzslsQ0AMwC08zwMwC06AS7U4TyATDlb6DbxXzzzzzzzzzzzlzzzzzzzzzzs0zzzzzzzzzzw0zzzzzzzzzzy0zzzzzzzzzzzty"
AutoAbility := "|<>*83$21.zzzzzzzwD4S0kXl28wS03Xk0QSH7nWMy0n7sCQzzzzU"
ClaimText := "|<>*127$71.00000000000000A7s01y000007zTs07w00000Tzlk0AQ00003k7VU0MM0000D03300kk0000Q0667zXzsw01k0AAzzzzzy031ysTrjTSyS0C7zky0AA0EQ0QCTVs0MM00Q0ss73U0kk00M1lkC711VVUUk3VnwC73333VU73zsQS666737y3tksQAAAC7zy01Uk0MMMQDzy030k0kkksTzy061U1VVVkzzz0y3kX77XXzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
LoadingScreen := "|<>*98$87.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwTzzzzzzzzzzzzX3zszzzzzszXzzsMTz7zzzzz7wDzz3XzszzzzzszVzzsTzz7zzzzz7wDkz3bwMz3szbszXs1sQS07U73sT7wS07XXU0w0QT7s03UkQQMA7b3Vkz00QD3XX3kzwCCDs03XwQQMz7s1llz7wQTXXX7sw0C4TszXXwQQMz73VsXz7wQD3XX3kswD0TszXk0wQQ0731w7z7wT0DXXU0s0DUzszXw3wQT17UFyDzzzzzzzzzzzzzlzzzzzzzzzzzzzgTw"
P := "|<>*88$35.3zzzy0Tzzzy0zzzzy3zzzzw7zzzzsTzzzzszzzzzlzzzzzXzw1zz7zs1zyDzk1zwTzV3zszz73zlzyC7zXzwQTz7zs0zyDzk3zwTzVzzszz7zzlzyDzzXzwTzz7zzzzyDzzzzwTzzzzszzzzzkzzzzzVzzzzy1zzzzw3zzzzk3zzzz00zzzs0000000000004"
P2 := "|<>*102$165.1zzzs000Dzzz0003zzzk000zzzw0zzzzk007zzzy001zzzzU00TzzzsDzzzz001zzzzs00Tzzzy007zzzzXzzzzw00TzzzzU07zzzzs01zzzzyTzzzzU03zzzzw00zzzzz00Dzzzzrzzzzy00zzzzzk0Dzzzzw03zzzzzzzzzzk07zw3zy01zzzzzU0Tzzzzzzzzzy00zy07zk0Dzzzzw03zlyDzzzzzzk07zU0Ty01zzzzzU0Ts30Tzzzzzy00zs01zk0Dzzzzw03y001zzz0zzk07y0k7y01zzzzzU0TU007zzvzzy00zU60Tk0Dzzzzw03w000zzzTzzk07w003y01zzzzTU0TU007zzvzzy00z000Dk0Dzzzzw03w000zzzzzzk07s0k1y01zzzzzU0TU007zzzzzy00z060Dk0Dzzzzw03y001zzzzzzk07s0k1y01zzzzzU0Tk00Dzzzzzy00z060Dk0Dzzzzw03z003zzzzzzk07s0k1y01zzzzzU0Tw00zzzzzzy00zU60Tk0Dzzzzw03zk0Dzzzzzzk07w0k3y01zzzzzU0Tz03zzzzzzy00zk60zk0Dzzzzw03zw0zzzzzzzk07z00Dy01zzzzzU0TzkDzzzzzzy00zw03zk0Dzzzzw03zzbzzzzzzzk07zk0zy01zzzzzU0Tzzzzzzzzzy00zzkzzk0Dzzzzw03zzzzzzzzzzk07zzzzy01zzzzzU0Tzzzzvzzzzw00TzzzzU07zzzzs01zzzzyTzzzzU03zzzzw00zzzzz00Dzzzzlzzzzs00Dzzzz003zzzzk00zzzzw7zzzy000zzzzk00Dzzzw003zzzz0Dzzz0001zzzs000Tzzy0007zzzUU"
Priority := "|<>*92$70.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs0000000000T00000000000s00000000001U0000000000600000000000M007zs000001U01zwU07U0060060200m000M00E1DvuA001U017zysss0060043W110U00M00E68442001U010MXkss006004TWD1X000M00Fu8x2C001U0168XUQ8006006En/1kU00M00D1zbxy001U0000870U00600000000000M00000000001k0000000000DU0000000001zzzzzzzzzzzzU"

; Just in case a player runs into "Cannot place unit" these values will hold that placement number. This is
; needed for every placement amount because FindText doesn't recognize the text "Cannot place more than" very well.
CannotPlaceUnit1:="|<>FF494C-0.90$479.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000000000000000000000C000000000000003k000Q01k000000003U0000DU0000000000000000S00000000000000000000000w000000000s0000DU001s07U00000000D003U3zk00000000003k0000w000000000000000000000S1s000000003k0000z00w3k0D000000000S3k70Dzs00000000007U0001s000000000000000000000w3k00000000DU0003y01s7U0C000000000Q7US0zzk0000000000D00003k000000000000000000001s7U00000000z00007U03kD0000000000000D0w3wD00000000000S00007U000000000000000000003kD000000003y0000D007US0000000000000S1s7k0000000000s0w0000D0000403U000001k000D007US00000000Dw00Q0S00D0w0007000000000w3kT007rXrsDTU7y7zU3rkS0TS1z0zk0SyDUDw7jVzU0zwxy0TSDTU0Ts03z3zk1ztvw7Vzk0w3XrsD7zbUw00Tz7zsTzUTyDz07zkw1zw7z3zk0zyzUzwDz7zU1ztzy1zwTzU0vk0Dz7zU3znzwD3zU1sD7zsSDzD1s01zyDzkzz1zyTy0Dzls7zsTyDzU1zzz3zwTyTz03znzw7zszz007U0zzDz07zbzsS7b03kSDzkwTyS3k03zwTzlzz7twTs0TznkDzkzwy7U3zzzDnsz9wD03z7zwTzlzz00D03wyDw07yDzswS007UwTzlsTsw7U0DXsy7XsSD1sS00y7bUyDXs1sD07lsyS3lw3kS03kDVsyDXsS00S07UwD007UT3lsT00D1sy7XkS0sD00S3lsD7UwS1sw01sDD1sD7U3sy0D3kww3nk7lw07US3lsD7Uw00w0D0wS00D0w7Xkzk0S3lsD7Uw1kT00w7XkSD1sw3ls03kSS3kSD07zs0S7Vts7bUDzk0D0w7XkSD1s01s0S1sw00S1sD7Uzk0w7XkSD1s00T01sD7UwS3lsD3k07kww7UwS0DU00wD3nkSD0T000S1sD7UwS3k03k0w7Vs00w3kSD0Tk0wD7UwS3k00z1nxyD1sw7Xsy7U0DztwDrszAT001sS7blwS0y000w3kSDrsw7U07U1wT3k01s7UwS07U1wyD1sw7U40zzXzwS3lsD3zwDs0TzVyDzkzwT703kwD7zsw0yC01z7UwDzlsD00D01zy7U03yD1swCD03zwS3lsDsQ0zzXzsw7XkS3zkDk0zy3wDzUzszy07VsS7zVs1zw01yD1sDzXkS00S01zsD003wS3lszw03zsw7XkDlw0zw3zls77UQ3z0TU1zs7sDz0zkzw0D3kw7y3k1zs03wS3kDz7UQ00w01zUS007sw3Xlzs03zls77UTXs0DU1X1UC60s1s0703k03U6A0S0Tk0C30k3k3U0zU00sQ3U6C60s00s00w0M001ks73Uz001XVUC7073U00000000000000007U000000000000000000000000000000000000000000000000000000000000000000000000000000D0000000000000000000000000000000000000000000000000000000000000000000000000000000S0000000000000000000000000000000000000000000000000000000000000000000000000000000w0000000000000000000000000000000000000000000000000000000000000000000000000000001s0000000000000000000000000000000000000000000000000000000000000000000000000000001U00000000000000000000000000000000000000000000000000000000000002"
CannotPlaceUnit2:="|<>FF494C-0.90$457.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003U000000000000000000000s00000000000000y000Q03U00000003U00003w0000000000000003k000000000000000000000w00000000z00000z000S03k00000003k03U07zU0000000001s0001s00000000000000000003kS00000000zs0000TU1sD01s00000001sS3k0Dzs0000000000w0000w00000000000000000001sD00000000zy0000TU0w7U0Q00000000QD1s07zw0000000000S0000S00000000000000000000w7U0000000Tz0000D00S3k000000000007Uw07kA0000000000D0000D00000000000000000000S3k0000000S7k0007U0D1s000000000003kS03k01nVnUCQ0DUTw0Qs7U7C0y0TU0tks0y0tkDk0zttk0tktk0D1s07kDy0Twws3Vy03UwQs3bzD03k03ztzwDzUTwDy0Ty3kDzVzkzs0zwz1zkzwTw0Twzy1zwzy07Uw0Dy7zUDyTz3lzk3kSTz3nzbU1s03zwzz7zsTz7z0DzVsDzlzszy0TzzVzwTyTz0DyTzVzyTzU3ky0DzXzk7zDzlszk1sDDzltznk0w01zyTzXzwDzXzU7zsw7zszwTD0DzzszyDyDbU7zDzkzzDzk00S07zlzk3zbzsww00w7bzswzts0S01wTDXtwTDXsS03swS7lwyAS3U7nswyDbkD1k0w7lwyDblw00z07lwD00S3sySC00S3nsyS7Uw0D00wDbUww7bUwD01sDD3kyS0D3k3kwSS3nk7Vs0S3kSS7nkS00z03kS7U0D1sDD7w0D1tsDD3kC07U0S3nkSS3nkS7U0w7bVsDD07zs1sSDD1ts3zw0D1sDD1tsD01z01sD3k07Uw7bXzU7Uww7bVs001s0D3tsDD1tsD3k0S3XkwDbU3zk0wD7bUww1zs07Uw7bVww7U1y00w7Vs03kS3nkTk3kSS3nkw000z3bnww7bUwyDVs0DrlsTDnsls00S7XnsyS0w003kS3ntyS3k1y00T7kw01sD1ts1s0wTD1tsS000DztzyS3nkSDzUz07zsz7zszwS60D3lszyD0D301yD1szzD1s1zz07zkS00z7UwwMQ0TzbUwwDls03zwzzD1tsD7zkTk3zsDXzwTyDzU7VswTz7U7zk0zbUwTzbUw0zzU3zsD00TnkSSTy07znkSS7ww00zwDzbUww7Uzk7s1zs7kzy3y3zk3ksS3z3k1zs0DnkS7znkS0Tzk0Ts7U07tsDDDy01xtsDD1yS007s0lVUAA1UDU0s0w00s360Q0Tk0kQ60y0k0Ds01kk60Mkk607zs07k1U00sM331y00AMM330C700000000000000000S000000000000000000000000000000000000000000000000000000000000000000000000000D0000000000000000000000000000000000000000000000000000000000000000000000000007U000000000000000000000000000000000000000000000000000000000000000000000000003k000000000000000000000000000000000000000000000000000000000000000000000000001s000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008"
CannotPlaceUnit3:="|<>FF494C-0.90$458.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000000000000000001k00000000000001w000s07000000007000003w0000000000000003k000000000000000000000w00000000zU0000z000S03k00000003k03U03zk0000000000w0000w00000000000000000001sD00000000Tw0000Dk0w7U0w00000000wD1s03zy0000000000D0000D00000000000000000000S3k0000000DzU0007s0D1s070000000073kS00zzU0000000003k0003k00000000000000000007Uw00000003tw0001s03kS000000000000w7U0T0k0000000000w0000w00000000000000000001sD00000000wD0000S00w7U00000000000D1s07U03b3b0Qs0T0zs0tkD0CQ1w0z01nVk1w1nUTU1znnU1nVnU063k0DUTw0zttk73w071stk7DyS03k03ztzwDzUTwDy0Ty3kDzVzkzs0zwz1zkzwTw0Twzy1zwzy007w0Dy7zUDyTz3lzk3kSTz3nzbU0w01zyTzXzwDzXzU7zkw7zszwTz0DzzkzyDzDzU7zDzkzzDzk03y07zlzs3zbzswTs0w7bzswzts0D00Tzbzszz3zszs1zyD1zyDz7nk3zzyDzXzXts1znzwDznzw00z01zwTw0ztzyDD00D1tzyDDyS03k0DXtwTDXtwT3k0T7XkyDblXkQ0yT7blwy1sC07UyDblwyDU0Ds0yDVs03kT7nlk03kST7nkw7U0w03kyS3nkSS3kw07UwwD3ts0wD0D3ltsDD0S7U1sD1tsTD1s00T0D1sS00w7UwwTk0w7bUwwD0s0D00w7bUww7bUwD01sDD3kSS0Dzk3kwSS3nk7zs0S3kSS3nkS0A3k3kS7U0D1sDD7z0D1tsDD3k001s0D3tsDD1tsD3k0S3XkwDbU3zk0wD7bUww1zs07Uw7bVww7U7Uw0w7Vs03kS3nkTk3kSS3nkw000TVntyS3nkST7kw07vswDbtwMw00D3ltwTD0S001sD1twzD1s1sD0DXsS00w7Uww0w0SDbUwwD0003zyTzbUww7XzsDk1zyDlzyDz7VU3kwSDzXk3kk0TXkSDznkS0Tzk1zw7U0DlsDD6707ztsDD3wS00TzbztsDD1szy3y0Tz1wTzXzlzw0wD7Xzsw0zy07ww7Xzww7U3zs0Tz1s03yS3nnzk0zyS3nkzbU03zkzyS3nkS3z0TU7zUT3zsDsDz0D3VsDwD07zU0zD1sTzD1s0Tw01zUS00TbUwwzs07rbUww7ts00Dk1X30MM30T01k1s01k6A0s0zU1UsA1w1U0Tk03VUA0lVUA01w00DU3001kk663w00Mkk660QC00000000000000000S0000000000000000000000000000000000000000000000000000000000000000000000000007U000000000000000000000000000000000000000000000000000000000000000000000000001s000000000000000000000000000000000000000000000000000000000000000000000000000S0000000000000000000000000000000000000000000000000000000000000000000000000007U0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000U"
CannotPlaceUnit4:="|<>FF494C-1.00$454.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000k000000000000000000000A000000000000007000600k00000000k00003s0000000000000003U000000000000000000000s00000001Vk0000y000Q03U00000003U0701zs0000000000Q0000S00000000000000000000s7U0000000C700007s0Q3k0C00000000C70Q0Dzk0000000001s0001s00000000000000000003kS00000000sQ0000y01sD00E00000000ES1k1yS00000000007U0007U0000000000000000000D1s00000003Vk0003k07Uw000000000001s70D000000000000S0000S00000000000000000000w7U0000000S70000D00S3k000000000007UQ0s008MME3203s3y06A1s0VU707k0AM60DUAQ3s07wS804AA801kQ01w1z03yD40kDU0k6640kzVk7U03vVrkCy0TkTw0Rw7UDi1z0zk0vtw1z0vsTs0ztvs1xkvs071k0DsDy0Twxw3Xz03UwRw3bz70S00TyDzVzw3zVzk3zsS1zsDy7z07zzsDy7z3zU3zbzkDz7zk0Q701zkzs1znzsSDw0S3nzsSTwQ1s03zszz7zsTT7z0DzlsDzVzkwS0TzzVxwTgSD0DyTzVzwTzU3kQ0DjXzU7zDzlss01sDDzltzlk7U0C7XkQS3VkQ7U0w77UsS707Us1sSD71ls3kQ0D1wC73lsC0Dzk0sC3k07Uy77XU07Uww77Vs70S01sCD1tsDD1sS03kQS7Usw0S3U7Vkww7bUD1k0w7Uww77Uw0zz07UwD00S3kSSDk0S3nkSS7UQ0s07Usw7bUww7Vs0D1lsS3Xk1zy0S73nkSS0zz03kS3nkQS3k3zw0S3kw01sD1tsTk0sDD1tsS003k0S3XkSS3nkS7U0w77VsCD07U01sQDD1ts3k00D1sDD1lsD001k1sD3k07Uw7bUTU3Uww7bVs007UMsSD1tsD71kS03swC3VsQ8C007VkwQ77U7000w7UwQD7Uw00703UsD00S3kSS0C0D3nkSS7U00TzXzsw7bUwTz1y0DzUyDzVzkw40S73lzwS0S203wS3lzwS3k00Q0DzUw01yD1tsks0zzD1tsTVk0zz7zXkSS3kzs3w0zw3sTy3zVzk1sQD3zVs0zs07tsD3zlsD001k0Tw3k03ww7bbzU1zww7bUz700zkDi71ssD1z07k3rUDUys7w3z03VkQ7w3U1zU0DXUw7r3Uw00700zUC007lkSCDw03vlkSC1wQ00w000000001k000D004000203s0000070001w0000000000000000s000000000D0000000000U0000000000000000w000000000000000000000000000000000000000000000000000000000000000000000000003k00000000000000000000000000000000000000000000000000000000000000000000000000D000000000000000000000000000000000000000000000000000000000000000000000000000w000000000000000000000000000000000000000000000000000000000000000000000000001k0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008"
CannotPlaceUnit5:="|<>FF494C-1.00$484.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000000000000000004000000000000000A0001004000000000800000C00000000000000000Q00000000000000000000000s000000007w00003s000C00s000000001k00k07z00000000000600001k000000000000000000000k3U00000000zs0000TU0A0s03U0000000070k3U0zy00000000000w000070000000000000000000007UC000000007zU0001y01s3U0C000000000Q7UC0Dzs00000000003k0000Q000000000000000000000S0s00000000Ty0000D007UC0000000000000S0s0y3U0000000000D00001k000000000000000000001s3U00000001s00000w00S0s0000000000001s3U7U000000000000w000070000000000000000000007UC000000007000003k01s3U0000000000007UC0Q007b3bUCS07sDz03bUQ0SQ1y0z00QwS0Dk7D1y01zsts0SQCS00Q000TUzw0TyCS0sDs070sQw1lzss3k01zwDz0zw1zkzw0Dz1k7zkTwDy01rvw3zUTwTw07zXzk7zkzw01z007z3zk1zszw3Vzk0Q3Vzs77zXUD007zkzy3zsDzXzk0zy70Tz3zlzw07zzsTz1znzs0TyDzUTz3zs0Dy00zyDz07zXzsC7201kC7zkQTyC0w00wT3twDbkwD3k03lsQ3lwD67Vs0STbVsS7UD3k0S0yT3lwDbk0zw03kwD007UDbksQ0070sTDVkS0s3k07UwC3ksD7UQD00C3lkS3ls0w7U1kwCD0sQ1sD01s3UwS3ksD01zs0S1kw00S0sD3Vs00Q3VkS71s3UD00S3ks73UQS1kw00sD71sD7U3kS073kww3Vk7Uw07UC1lsD3UQ003U1s73k01s3UQC7w01kC70sQ7UA0Q01sD3UQC1ls73k03UwQ7UwS0Dzk0QD3nkC70TzU0S0s77UwC1k00D07UQD007UC1ksDw070sQ3VkS001s07UwC1ks77UQD00C3lkS3ls0w001kwDD0sQ1s001s3UQS3ks7000w0S1kw00S0s73U7k0Q7VkC71s003sCD7ks73UQD3kw00wS70wT3kVk0073kwS7Vk3U007UC1kwT3UQ063U0wD3k01s3UQC07U1sS70sQ7U007zszz3UQC1kzy1y03zsT3zwDz7UU0QD3lzw70D100Dks73zwC1k0zy03zsD003wC1ksMQ07zsQ3VkDks0DzVzwC1ks71zs7s0Dz1y7zkTwDz01kwD3zkQ0Ty00z3UQ7zks703zk07zUw00Dks73Xzk0DzVkC70z3U0Tw3tks73UQ3y0DU0vk3sDb0zUTw073ks7w1k0zs01wC1kDb3UQ07y00Ds3k00T3UQC7y00TC70sQ1wC00C0000000003U0003U000000M0T00000070000y00000000000007U00C00000000007U0000000000E00000000000000000C00000000000000000000000000000000000000000000000000000000000000000000000000000000s00000000000000000000000000000000000000000000000000000000000000000000000000000003U0000000000000000000000000000000000000000000000000000000000000000000000000000000C00000000000000000000000000000000000000000000000000000000000000000000000000000000s00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008"
;CannotPlaceUnitUnique <message capture here>, then add to array below
CannotPlaceUnitsArr := [CannotPlaceUnit1, CannotPlaceUnit2, CannotPlaceUnit3, CannotPlaceUnit4, CannotPlaceUnit5]


CheckForUpdates()

global backToLobbyEnabled := 1
global cardPickerEnabled := 1
global hasReconnect := 0
global matchMakingEnabled := 0
global GameModes := Map()
GameModes["halloweenEvent"] := () => GoToHalloweenEvent()
GameModes["infinityCastle"] := () => GoToInfinityCastle()
GameModes["christmasEvent"] := () => GoToRaids()
GameModes["default"] := () => GoToRaids()
global currentGameMode := "infinityCastle"
global maps := [
    PlanetGreenie(),
    WalledCity()
]

SetupMacro() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    if WinExist(RobloxWindow) {
        WinActivate(RobloxWindow)
        Sleep 50
        WinMove(27, 15, 800, 600, RobloxWindow)
        Sleep 50
    }
    if WinExist("Taxi Winter Event Farm") {
        Sleep 50
        WinActivate("Taxi Winter Event Farm")
        Sleep 100
    }

}

InitializeMacro() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    global MacroStartTime := A_TickCount

    if WinExist("Taxi Auto-Challenge") {
        WinActivate("Taxi Auto-Challenge")
    }

    if WinExist(RobloxWindow) {
        WinMove(27, 15, 800, 600, RobloxWindow)
        WinActivate(RobloxWindow)
        Sleep 100
    }
    else {
        MsgBox("You must have ROBLOX open in order to start the macro (microsoft roblox doesnt work)", "Error T4", "+0x1000",)
        return
    }

    if (ok := FindText(&X, &Y, 746, 476, 862, 569, 0, 0, AreasText)) {
        GameModes[currentGameMode].Call()
    }
    else {
        MsgBox("You must be in the lobby with default camera angle to start the macro.", "Error T3", "+0x1000",)
        return
    }

}

SetDefaultKeyboard(localeID) {
    static SPI_SETDEFAULTINPUTLANG := 0x005A, SPIF_SENDWININICHANGE := 2
    Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
    binaryLocaleID := Buffer(4, 0)
    NumPut("UInt", LocaleID, binaryLocaleID)
    DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "Ptr", binaryLocaleID, "UInt", SPIF_SENDWININICHANGE)
    for hwnd in WinGetList()
        PostMessage 0x50, 0, Lan, , hwnd
}

BetterClick(x, y, LR := "Left") { ; credits to yuh for this, lowk a life saver
    MouseMove(x, y)
    MouseMove(1, 0, , "R")
    MouseClick(LR, -1, 0, , , , "R")
    Sleep(50)
}

; By @Durrenth
;TODO: Find infinity castle button and click it
; Move player to infinity castle circle
; Detect latest room and click it
GoToInfinityCastle() {
    Loop {
        SendInput ("{Tab}")
        exitLoop := 0
        routingMovement := 1
        loop {
            for map in maps {
                if (ok:=FindText(&X, &Y, 41, 108, 568, 173, 0, 0, map.MapImage))
                    {
                      exitLoop :=1
                    }
            }
    
            
            if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
                AddToLog("Found VoteStart, stopping loop")
                exitLoop := 1
            }
    
            Sleep 100
    
            if(routingMovement == false) {
                continue
            }
    
            BetterClick(770, 470)
            Sleep 750
            BetterClick(280, 340)
            Sleep 4000
            SendInput ("{a down}")
            Sleep 3000
            SendInput ("{a up}")
            SendInput ("{w down}")
            Sleep 600
            SendInput ("{w up}")
            Sleep 2000
            ;BetterClick(430,390) Normal difficulty Coords
            BetterClick(425,440)
            routingMovement := 0
            ;AntiCaptcha()
            
        } until (exitLoop) ; end inner loop
        MapPlacementInstructions()
        AddToLog("Finished game")
        LobbyLoop()
    } ; end outer loop
}

GoToHalloweenEvent(){
    loop {
        enteredRoom := 0
        exitLoop := 0
        SendInput ("{Tab}")
        loop {
    
            for map in maps {
                if (ok:=FindText(&X, &Y, 41, 108, 568, 173, 0, 0, map.MapImage))
                    {
                      exitLoop :=1
                    }
            }
    
            if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
                AddToLog("Found VoteStart, stopping loop")
                exitLoop := 1
            }
    
            Sleep 100
            
            if(enteredRoom = true) {
                continue
            }
            
                BetterClick(89, 302)
                Sleep 2000
                SendInput ("{w down}")
                Sleep 2000
                SendInput ("{w up}")
                Sleep 100
                SendInput ("{a down}")
                Sleep 5000
                SendInput ("{a up}")
                KeyWait "a"
                Sleep 1200
                if (matchMakingEnabled) {
                    BetterClick(469, 340) ; play (matchmaking mode)
                    Sleep 2000
                    AntiCaptcha()
                } else {
                    BetterClick(380, 340) ; play (non-matchmaking mode)
                    Sleep 2000
                }
                Sleep 2000
                enteredRoom :=1
    
        } until (exitLoop) ; end inner loop

        MapPlacementInstructions()
        LobbyLoop()
    } ; end outer loop
}

GoToRaids() {
    loop {
        SendInput ("{Tab}")
        loop {
            ; go to xmas map
            if (ok := FindText(&X, &Y, 10, 70, 350, 205, 0, 0, LoadingScreen)) {
                AddToLog("Found LoadingScreen, stopping loop")
                break
            }
            if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
                AddToLog("Found VoteStart, stopping loop")
                break
            }
            if (ok := FindText(&X, &Y, 338, 505, 536, 572, 0, 0, ClaimText)) ; daily reward
            {
                BetterClick(406, 497)
                Sleep 3000
            }
    
            ; go to xmas map
            BetterClick(89, 302)
            Sleep 2000
            SendInput ("{a up}")
            ; go to teleporter
            Sleep 100
            SendInput ("{a down}")
            Sleep 6000
            SendInput ("{a up}")
            KeyWait "a" ; Wait for "d" to be fully processed
    
            ;sacred planet act 4
            Sleep 1200
            if (matchMakingEnabled) {
                BetterClick(469, 340) ; play (matchmaking mode)
                Sleep 2000
                AntiCaptcha()
            } else {
                BetterClick(380, 340) ; play (non-matchmaking mode)
                Sleep 2000
            }
    
        } ; end inner loop
        LoadedLoop()
        StartedLoop()
        OnSpawnSetup()
        TryPlacingUnits()
        AddToLog("Finished game")
        LobbyLoop()
    } ; end outer loop

}

StopMacro() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    Reload()
}

DetectMapName() {

    for map in maps {
        if (ok:=FindText(&X, &Y, 41, 108, 568, 173, 0, 0, map.MapImage))
            {
              return map.Name
            }
    }

    return "UnknownMap"

}

MapPlacementInstructions() {
    loop {
        AddToLog("Attempting to detect map name...")
        mapName := DetectMapName()
    
        ; Create a Map object
        mapClasses := Map()
        mapClasses["PlanetGreenie"] := PlanetGreenie()
        mapClasses["WalledCity"] := WalledCity()
        mapClasses["UnknownMap"] := BaseMap()
    
        AddToLog("Detected mapName: " . mapName) ; Display detected map name
        
        ; Loop over mapClasses to find the selected map
        selectedMap := ""
        for key, value in mapClasses {
            if (key = mapName) {
                selectedMap := value
                break  ; Exit loop once the map is found
            }
        }
    
        if (selectedMap = "") {
            AddToLog("UnknownMap")
            selectedMap := mapClasses["UnknownMap"]
        }
        
        ; Run instructions for the selected map
        LoadedLoop()
        AddToLog("Entering Started Loop")
        StartedLoop()
        AddToLog("Entering On spawn setup")
        selectedMap.OnSpawnSetupGlobal
        AddToLog("entering run instructions")
        selectedMap.RunInstructions
        AddToLog("placing units")
        selectedMap.TryPlacingUnits
        AddToLog("returned to MapPlacemenInstructions")

        if !(backToLobbyEnabled) {
            continue
        } 

        break ; break out of loop if replaying is disabled.

    }
    return ; return to GoToGamemode function
}


; Define the rectangle coordinates
global startX := 100, startY := 500, endX := 700, endY := 350
global startY2 := 200, endY2 := 350
global step := 50 ; Step size for grid traversal
global successfulCoordinates := [] ; Array to store successful placements
global successThreshold := 3 ; Number of successful placements needed

PlaceUnit(x, y, slot := 1) {
    SendInput(slot)
    Sleep 50
    BetterClick(x, y)
    Sleep 50
    SendInput("q")

    ; Check if placement is successful
    if IsPlacementSuccessful() {
        Sleep 15
        return true
    }
    return false
}

IsPlacementSuccessful() {

    Sleep 1000
    if (ok := FindText(&X, &Y, 78, 182, 400, 451, 0, 0, UnitExistence)) {
        AddToLog("placed unit successfully")
        BetterClick(329, 184) ; close upg menu
        return true
    }
    else if (ok := FindText(&X, &Y, 88 - 150000, 416 - 150000, 88 + 150000, 416 + 150000, 0, 0, Priority))
    {
        AddToLog("placed unit successfully by priority")
        BetterClick(329, 184) ; close upg menu
        return true
    }
    return false
}

CannotPlaceUnits() {
    global CannotPlaceUnitsArr ; Pretty sure this line here isin't needed but it works so I'm leaving it
    AddToLog("Entered Cannot Place Units")
    for index, placementAmount in CannotPlaceUnitsArr {
        if (ok := FindText(&X, &Y, 154, 478, 700, 531, 0, 0, placementAmount)) {
            return true
        }
    }
    return false
}


Numpad5:: {
    SendWebhook()
}

GetWindowCenter(WinTitle) {
    x := 0 y := 0 Width := 0 Height := 0
    WinGetPos(&X, &Y, &Width, &Height, WinTitle)

    centerX := X + (Width / 2)
    centerY := Y + (Height / 2)

    return { x: centerX, y: centerY, width: Width, height: Height }
}

rect1 := { x: 37, y: 45, width: 254, height: 69 }
rect2 := { x: 591, y: 45, width: 243, height: 47 }
rect3 := { x: 36, y: 594, width: 105, height: 51 }

isInsideRect(rect, x, y) {
    return (x >= rect.x and x <= rect.x + rect.width and y >= rect.y and y <= rect.y + rect.height)
}

; ********* PLACEMENT ALGOS START HERE **********

;By @keirahela
SpiralPlacement(gridPlacement := false) {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []
    savedPlacements := Map()

    centerX := GetWindowCenter(RobloxWindow).x
    centerY := GetWindowCenter(RobloxWindow).y
    radius := step
    direction := [[1, 0], [0, 1], [-1, 0], [0, -1]]
    dirIndex := 0
    directionCount := 0

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        currentX := centerX
        currentY := centerY
        steps := 30
        maxSteps := 5

        while (placementCount < placements) {
            for index, stepSize in [steps] {

                if PlaceUnit(currentX, currentY, slotNum) {
                    placementCount++
                    successfulCoordinates.Push({ x: currentX, y: currentY, slot: "slot_" slotNum }) ; Track successful placements
                    try {
                        if savedPlacements.Get("slot_" slotNum) {
                            savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                        }
                    } catch {
                        savedPlacements.Set("slot_" slotNum, 1)
                    }

                    if placementCount >= placements {
                        break
                    }

                    if (gridPlacement) {
                        PlaceInGrid(currentX, currentY, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &placements)
                    }

                }

                if(CannotPlaceUnits()) {
                    break
                }

                if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
                {
                    BetterClick(373, 237)
                }
                if (cardPickerEnabled = 1) {
                    if (ok := FindText(&cardX, &cardY, 391 - 150000, 249 - 150000, 391 + 150000, 249 + 150000, 0, 0, pick_card)) { ; CARD PICKER
                        cardSelector()
                    }
                }
                BetterClick(348, 391) ; next
                BetterClick(565, 563) ; move mouse
                if ShouldStopUpgrading(1) {
                    AddToLog("Stopping due to finding lobby condition. Returning from SpirePlacement")
                    return ; Go back to MapPlacementInstructions or TryPlacingUnits
                }
                Reconnect()

                currentX += direction[dirIndex + 1][1] * steps
                currentY += direction[dirIndex + 1][2] * steps

                currentX += Random(-15, 15)
                currentY += Random(-15, 15)

                if isInsideRect(rect1, currentX, currentY) or isInsideRect(rect2, currentX, currentY) or isInsideRect(rect3, currentX, currentY) {
                    steps := 30
                    currentX := centerX
                    currentY := centerY
                }

                if currentX > 780 or currentY > 580 or currentX <= 0 or currentY < 0 {
                    steps := 30
                    currentX := centerX
                    currentY := centerY
                }
            }

            directionCount++

            if directionCount == 2 {
                steps += 30
                directionCount := 0
            }

            dirIndex := Mod(dirIndex + 1, 4)
            if ShouldStopUpgrading(1) {
                AddToLog("Stopping due to finding lobby condition. Returning from SpirePlacement")
                return ; Go back to MapPlacementInstructions or TryPlacingUnits
            }
        }

        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
    }

    UpgradeUnits()
    AddToLog("Returned from UpgradeUnits.")
    return ; Go back to MapPlacementInstructions or TryPlacingUnits
}

; The OG placement by @Original author of macro
LinePlacement() {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []

    x := startX ; Initialize x only once
    y := startY ; Initialize y only once
    y2 := startY2 ; Initialize y2 only once

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        alternatingPlacement := 0

        ; Continue placement for the current slot
        while (placementCount < placements && y >= endY && y2 <= endY2) { ; Rows
            while (placementCount < placements && x <= endX) { ; Columns
                if (alternatingPlacement == 0) {
                    if PlaceUnit(x, y2, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y2, slot: "slot_" slotNum }) ; Track successful placements
                    }
                }

                if(CannotPlaceUnits()) {
                    break
                }

                if (alternatingPlacement == 1) {
                    if PlaceUnit(x, y, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y, slot: "slot_" slotNum }) ; Track successful placements
                    }
                }

                if(CannotPlaceUnits()) {
                    break
                }

                if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
                {
                    BetterClick(373, 237)
                }
                if (cardPickerEnabled = 1) {
                    if (ok := FindText(&cardX, &cardY, 391 - 150000, 249 - 150000, 391 + 150000, 249 + 150000, 0, 0, pick_card)) { ; CARD PICKER
                        cardSelector()
                        ;AddToLog("Succesfully picked card")
                    }
                }
                BetterClick(348, 391) ; next
                BetterClick(565, 563) ; move mouse
                if ShouldStopUpgrading(1) {
                    AddToLog("Stopping due to finding lobby condition. Returning from LinePlaceMent")
                    return ; Go back to MapPlacementInstructions or TryPlacingUnits
                }
                Reconnect()
                x += step - 20 ; Move to the next column
            }
            if x > endX {
                x := startX ; Reset x for the next row
                if (Mod(alternatingPlacement, 2) == 0) {
                    y2 += (step + 25) ; Move to the next row, upwards
                    alternatingPlacement += 1
                }
                else {
                    y -= (step + 25) ; Move to the next row, downwards
                    alternatingPlacement -= 1
                }
            }
            Reconnect()
        }

        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
        Reconnect()
    }

    UpgradeUnits()
    AddToLog("Returned from UpgradeUnits.")
    return ; Go back to MapPlacementInstructions or TryPlacingUnits
}

; Modified version of LinePlaceMent, placing in a 2x2 grid when a unit is placed,then goes back to line placing
; By @Durrenth
LinePlacementGrid() {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []
    savedPlacements := Map()

    x := startX ; Initialize x only once
    y := startY ; Initialize y only once
    y2 := startY2 ; Initialize y2 only once

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        alternatingPlacement := 0

        ; Continue placement for the current slot
        while (placementCount < placements && y >= endY && y2 <= endY2) { ; Rows
            while (placementCount < placements && x <= endX) { ; Columns
                if (alternatingPlacement == 0) {

                    if PlaceUnit(x, y2, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y2, slot: "slot_" slotNum }) ; Track successful placements

                        try {
                            if savedPlacements.Get("slot_" slotNum) {
                                savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                            }
                        } catch {
                            savedPlacements.Set("slot_" slotNum, 1)
                        }

                        if placementCount >= placements {
                            break
                        }

                        PlaceInGrid(x, y2, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &placements)
                    }

                    if(CannotPlaceUnits()) {
                        break
                    }
                    
                }

                if (alternatingPlacement == 1) {
                    if PlaceUnit(x, y, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y, slot: "slot_" slotNum }) ; Track successful placements

                        try {
                            if savedPlacements.Get("slot_" slotNum) {
                                savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                            }
                        } catch {
                            savedPlacements.Set("slot_" slotNum, 1)
                        }

                        if placementCount >= placements {
                            break
                        }

                        PlaceInGrid(x, y2, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &placements)
                        
                    }

                    if(CannotPlaceUnits()) {
                        break
                    }

                }
                if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
                {
                    BetterClick(373, 237)
                }
                if (cardPickerEnabled = 1) {
                    if (ok := FindText(&cardX, &cardY, 391 - 150000, 249 - 150000, 391 + 150000, 249 + 150000, 0, 0, pick_card)) { ; CARD PICKER
                        cardSelector()
                        ;AddToLog("Succesfully picked card")
                    }
                }
                BetterClick(348, 391) ; next
                BetterClick(565, 563) ; move mouse
                if ShouldStopUpgrading(1) {
                    AddToLog("Stopping due to finding lobby condition. Returning from LinePlacementGrid")
                    return ; Go back to MapPlacementInstructions or TryPlacingUnits
                }
                Reconnect()
                x += step - 20 ; Move to the next column
            }
            if x > endX {
                x := startX ; Reset x for the next row
                if (Mod(alternatingPlacement, 2) == 0) {
                    y2 += (step + 25) ; Move to the next row, upwards
                    alternatingPlacement += 1
                }
                else {
                    y -= (step + 25) ; Move to the next row, downwards
                    alternatingPlacement -= 1
                }
            }
            Reconnect()
        }

        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
        Reconnect()
    }

    UpgradeUnits()
    AddToLog("Returned from UpgradeUnits.")
    return ; Go back to MapPlacementInstructions or TryPlacingUnits
}

; Places units in a zig-zag pattern
; By @Durrenth
ZigZagPlacement(gridPlacement := false) {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []
    savedPlacements := Map()

    startY2 := 200, endY2 := 500
    startY := 170, endY :=470

    rectZigZag := { x: startX, y: startY, width: 670 , height: 500 }

    ; += Random(0, 15)

    x := startX + Random(0, 15) ; Incase 2 or more players are using the same placement, randomize starting location by 0-15 steps.
    y1 := startY ; Initialize y only once
    y2 := startY2 ; Initialize y2 only once
    y := y1 ; Start with the top Y coordinate

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        alternatingPlacement := 0

        while (placementCount < placements) {

            ; if(CannotPlaceUnits()) {
            ;     break
            ; }

            if PlaceUnit(x, y, slotNum) {
                placementCount++
                successfulCoordinates.Push({ x: x, y: y, slot: "slot_" slotNum }) ; Track successful placements
                ;AddToLog("Unit placed at x: " x ", y: " y)
                try {
                    if savedPlacements.Get("slot_" slotNum) {
                        savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                    }
                } catch {
                    savedPlacements.Set("slot_" slotNum, 1)
                }
                
                if placementCount >= placements {
                    break
                }

                if (gridPlacement) {
                    if(PlaceInGrid(x, y, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &placements)) {
                        return
                    }
                }

            }

            if(CannotPlaceUnits()) {
                break
            }

            if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
            {
                BetterClick(373, 237)
            }
            if (cardPickerEnabled = 1) {
                if (ok := FindText(&cardX, &cardY, 391 - 150000, 249 - 150000, 391 + 150000, 249 + 150000, 0, 0, pick_card)) { ; CARD PICKER
                    cardSelector()
                    ;AddToLog("Succesfully picked card")
                }
            }
            BetterClick(348, 391) ; next
            BetterClick(565, 563) ; move mouse
            if ShouldStopUpgrading(1) {
                AddToLog("Stopping due to finding lobby condition. Returning from ZigZagPlacement")
                return ; Go back to MapPlacementInstructions or TryPlacingUnits
            }
            Reconnect()
            
            ; Move to the next X-coordinate
            x += step
            ;AddToLog("x: " x ", y: " y)

             ; If X exceeds the end range, reset it and move down
             if (isInsideRect(rectZigZag, x, y)) {
                ; Alternate y between y1 and y2 for zig-zag effect
                y := (y = y1) ? y2 : y1
            } else {

                ; Incase y value goes out of bounds, re-initialize starting locations, and add a huge offset to x
                if (y >= endY) {
                    AddToLog("Reached end of Y-range or coordinates are outside rectangles. Moving to the next row.")
                    x := startX + Random(20,40) ; Reset x to the starting position, add random offset to it incase 2 players are using same placement style
                    startY := 170
                    startY2 := 200
                    y1 := startY
                    y2 := startY2
                    y := y1
                } else { ; If y isin't OOB
                    AddToLog("Reached end of X-range or coordinates are outside rectangles. Moving to the next row.")
                    x := startX + Random(0,15) ; Reset x to the starting position, add random offset to it incase 2 players are using same placement style
                    y1 := startY + step ; Move top Y-coordinate down
                    y2 := startY2 + step ; Move bottom Y-coordinate down
                    startY := y1 ; This is needed incase you loop again. Otherwise you will keep starting at the default startY/startY2 locations
                    startY2 := y2
                    y := y1 ; Start the new row with the top Y-coordinate
                }

            }
            
            
        } ; End While
        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
        Reconnect()
    } ; End For
    UpgradeUnits()
    AddToLog("Returned from UpgradeUnits.")
    return ; Go back to MapPlacementInstructions or TryPlacingUnits
}

; Algorithm that's used in LinePlacement. Is a helper function. Attempts to place units in a 2x2 grid once an initial unit has been placed.
; Can be combined withother placement algos.
; by @Durrenth
PlaceInGrid(startX, startY, slotNum, & placementCount, & successfulCoordinates, & savedPlacements, & placements) {
    ; Places untis in a 2x2 grid, starting from the top left where the initial unit is placed (as dictated by startX and startY)
    ; U x
    ; x x 
       ;"Y"     ;"X"   
    ;[number1,number2]

    gridOffsets := [
       [30, 0],  ; Row 1, Column 0
       [0, 30],  ; Row 0, Column 1
       [30, 30]   ; Row 1, Column 1
   ]
   for index, offset in gridOffsets {

       ; Adds the value that's stored in the array at the current index to either x or y's starting location 
       gridX := startX + offset[2] ; Move horizontally by 'step' from the initial start location
       gridY := startY + offset[1] ; Move vertically by 'step' from the initial start location

       if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
        {
            BetterClick(373, 237)
        }
       ; Handle card picker and related logic during grid placement
       if (cardPickerEnabled = 1) {
           if (ok := FindText(&cardX, &cardY, 391 - 150000, 249 - 150000, 391 + 150000, 249 + 150000, 0, 0, pick_card)) { ; CARD PICKER
               cardSelector()
               AddToLog("Successfully picked card")
           }
       }
       BetterClick(348, 391) ; next
       BetterClick(565, 563) ; move mouse
       if ShouldStopUpgrading(1) {
           AddToLog("Stopping due to finding lobby condition.")
           return true ;Go back to Placement Types
       }
       Reconnect()

       if PlaceUnit(gridX, gridY, slotNum) {
           placementCount++ ; Increment the placement count
           successfulCoordinates.Push({ x: gridX, y: gridY, slot: "slot_" slotNum }) ; Track the placement
           ;AddToLog("Placed unit at (" gridX ", " gridY ") in 2x2 grid.")

           ; Update or initialize saved placements for the current slot
           try {
               if savedPlacements.Get("slot_" slotNum) {
                   savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
               }
           } catch {
               savedPlacements.Set("slot_" slotNum, 1)
           }

           ; Check if placement limit is reached
           if placementCount >= placements {
               break
           }

       }

   } ; End for
   return false
}

; Add placement options here
TryPlacingUnits() {
    switch PlacementDropdown.Text {
        case "Spiral":
            SpiralPlacement()
        case "Lines": 
            LinePlacement()
        case "Lines + 2x2 Grid Finder":
            LinePlacementGrid()
        case "Zig Zag":
            ZigZagPlacement()
        case "Zig Zag + 2x2 Grid Finder":
            ZigZagPlacement(true)
        case "Spiral + 2x2 Grid Finder":
            SpiralPlacement(true)
        default:
            AddToLog("Invalid selection")
    }
    return ; Go back to Gamemodes
}

IsMaxed(coord) {
    global maxedCoordinates
    for _, maxedCoord in maxedCoordinates {
        if (maxedCoord.x = coord.x && maxedCoord.y = coord.y) {
            return true
        }
    }
    return false
}

UpgradeUnits() {
    if UUPCheckbox.Value = 1 {
        global successfulCoordinates, maxedCoordinates, unitUpgradePrioritydropDowns
        AddToLog("Beginning prioritized unit upgrades.")

        priorityMapping := []
        for index, dropDown in unitUpgradePrioritydropDowns {
            priorityText := dropDown.Text
            if priorityText && priorityText != "" {
                priorityMapping.Push(priorityText)
            }
        }

        SortByPriority(&successfulCoordinates, priorityMapping)

        for coord in successfulCoordinates {
            if IsMaxed(coord) {
                AddToLog("Unit already maxed at: X" coord.x " Y" coord.y ". Skipping upgrade.")
                continue
            }
            while !IsMaxUpgrade() {
                UpgradeUnit(coord.x, coord.y)
                if (IsMaxUpgrade()) {
                    break
                }
                if ShouldStopUpgrading() {
                    AddToLog("Stopping due to finding return to lobby/replay button.")
                    successfulCoordinates := []
                    maxedCoordinates := []
                    return ; return to calling PlacementFunction
                }

                Sleep(200)

                if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) {
                    BetterClick(373, 237)
                }
                if (cardPickerEnabled = 1 && (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, pick_card))) {
                    cardSelector()
                }
                BetterClick(348, 391) ; next
                BetterClick(565, 563) ; move mouse
                Reconnect()
            }

            if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
            {
                BetterClick(373, 237)
            }

            BetterClick(565, 563) ; move mouse
            AddToLog("Max upgrade reached for: X" coord.x " Y" coord.y ". Moving onto next unit")
            maxedCoordinates.Push(coord)
        }

        AddToLog("All units upgraded or maxed.")
        while !ShouldStopUpgrading() {
            BetterClick(348, 391) ; next
            Sleep(200)
            if (cardPickerEnabled = 1 && (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, pick_card))) {
                cardSelector()
            }
        }

        return ; return to calling PlacementFunction

    }
    else
    {
        global successfulCoordinates
        global maxedCoordinates

        AddToLog("Beginning unit upgrades.")

        while true { ; Infinite loop to ensure continuous checking
            for index, coord in successfulCoordinates {

                UpgradeUnit(coord.x, coord.y)

                if ShouldStopUpgrading() {
                    AddToLog("Stopping due to finding return to lobby/replay button.")
                    successfulCoordinates := []
                    maxedCoordinates := []
                    return ; return to calling PlacementFunction
                }

                if IsMaxUpgrade() {
                    AddToLog("Max upgrade reached for: X" coord.x " Y" coord.y)
                    maxedCoordinates.Push(successfulCoordinates.Get(index))
                    successfulCoordinates.RemoveAt(index) ; Remove the coordinate
                    continue ; Skip to the next coordinate
                }

                Sleep(200)
                if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
                {
                    BetterClick(373, 237)
                }
                if (cardPickerEnabled = 1) {
                    if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, pick_card)) { ; CARD PICKER
                        cardSelector()
                        ;AddToLog("Succesfully picked card")
                    }
                }
                BetterClick(348, 391) ; next
                BetterClick(565, 563) ; move mouse
                Reconnect()
            }

            ; If all units are maxed, still check for stopping condition
            if successfulCoordinates.Length = 0 and maxedCoordinates.Length > 0 {
                Reconnect()
                if (cardPickerEnabled = 1) {
                    if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, pick_card)) { ; CARD PICKER
                        cardSelector()
                        ;AddToLog("Succesfully picked card")
                    }
                }
                BetterClick(348, 391) ; next
                if ShouldStopUpgrading() {
                    AddToLog("Stopping due to finding return to lobby/replay button.")
                    return ; return to calling PlacementFunction
                }
                Sleep(2000) ; Prevent excessive looping

            }

            Reconnect()
        } ; End While
    }
}

SortByPriority(&array, priorityMapping) {
    AddToLog("Starting unit sorting by priority mapping")
    sortedArray := []

    for index, slot in priorityMapping {
        foundSlot := false

        for i, item in array {
            if (item.slot = slot) {
                sortedArray.Push(item)
                foundSlot := true
            }
        }

        if !foundSlot {
            AddToLog("No units found for: " slot ". Moving onto next slot")
        }
    }

    array := sortedArray
    AddToLog("Finished sorting units, starting upgrading")
}


/*UpgradeUnits() {
    global successfulCoordinates
    global maxedCoordinates

    AddToLog("Beginning unit upgrades.")

    while true { ; Infinite loop to ensure continuous checking
        for index, coord in successfulCoordinates {

            UpgradeUnit(coord.x, coord.y)

            if ShouldStopUpgrading() {
                AddToLog("Found return to lobby, going back.")
                successfulCoordinates := []
                maxedCoordinates := []
                return LobbyLoop()
            }

            if IsMaxUpgrade() {
                AddToLog("Max upgrade reached for: X" coord.x " Y" coord.y)
                maxedCoordinates.Push(successfulCoordinates.Get(index))
                successfulCoordinates.RemoveAt(index) ; Remove the coordinate
                continue ; Skip to the next coordinate
            }

            Sleep(200)
            if (ok := FindText(&X, &Y, 334, 182, 450, 445, 0, 0, AutoAbility)) ; USE ABILITY IF OFF
            {
                BetterClick(373, 237)
            }
            if (cardPickerEnabled = 1) {
                if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, pick_card)) { ; CARD PICKER
                    cardSelector()
                    ;AddToLog("Succesfully picked card")
                }
            }
            BetterClick(348, 391) ; next
            BetterClick(565, 563) ; move mouse
            Reconnect()
        }

        ; If all units are maxed, still check for stopping condition
        if successfulCoordinates.Length = 0 and maxedCoordinates.Length > 0 {
            Reconnect()
            if (cardPickerEnabled = 1) {
                if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, pick_card)) { ; CARD PICKER
                    cardSelector()
                    ;AddToLog("Succesfully picked card")
                }
            }
            BetterClick(348, 391) ; next
            if ShouldStopUpgrading() {
                AddToLog("Stopping due to finding return to lobby button.")
                return LobbyLoop()
            }
            Sleep(2000) ; Prevent excessive looping

        }

        Reconnect()
    }
}*/


UpgradeUnit(x, y) {
    BetterClick(x, y - 3)
    BetterClick(264, 363) ; upgrade
    BetterClick(264, 363) ; upgrade
    BetterClick(264, 363) ; upgrade
}

IsMaxUpgrade() {
    Sleep 500
    if (ok := FindText(&X, &Y, 142, 346, 406, 472, 0, 0, MaxUpgrade) or (ok := FindText(&X, &Y, 142, 346, 406, 472, 0, 0, MaxUpgrade2)) or (ok := FindText(&X, &Y, 142, 346, 406, 472, 0, 0, MaxUpgrade3)))
    {
        return true
    }
}

ShouldStopUpgrading(sleepamount := 300) {
    Sleep sleepamount

    if CheckForLobbyButton() {
        if (WebhookCheckbox.Value = 1) {
            SendInput ("{Tab}")
            Sleep 100
            SendWebhook()
        }

        if (backToLobbyEnabled) {
            BetterClick(376, 117) ; Back to Lobby
        } else {
            BetterClick(540, 117) ; Replay
        }

        AddToLog("Should Stop Upgrading returned true")
        return true
    }

}

FindAndClickColor(targetColor := 0x006783, searchArea := [0, 0, A_ScreenWidth, A_ScreenHeight]) {
    ; Extract the search area boundaries
    x1 := searchArea[1], y1 := searchArea[2], x2 := searchArea[3], y2 := searchArea[4]

    ; Perform the pixel search
    if (PixelSearch(&foundX, &foundY, x1, y1, x2, y2, targetColor, 0)) {
        ; Color found, click on the detected coordinates
        BetterClick(foundX, foundY, "Right")
        AddToLog("Color found and clicked at: X" foundX " Y" foundY)
        return true

    } else {
    }
}


OnSpawn() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    OnSpawnSetup()
}

LookDown() {
    MouseMove(400, 300)
    loop 20 {
        SendInput("{WheelUp}")
        Sleep 50
    }
    Sleep 200
    MouseGetPos(&x, &y)
    MouseMove(400, 300)
    SendInput(Format("{Click {} {} Left}", x, y + 150))

    loop 20 {
        SendInput("{WheelDown}")
        Sleep 50
    }
}

LoadedLoop() {
    global hasReconnect
    AddToLog("Waiting to load in")
    loop {
        Sleep 1000
        if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart))
        {
            global StageStartTime := A_TickCount
            AddToLog("Loaded in")
            if (hasReconnect == 1 && DisconnectCheckbox.Value == 1) {
                sendRCWebhook()
                hasReconnect := 0
            }
            Sleep 1000
            BetterClick(350, 103) ; click yes
            BetterClick(350, 100) ; click yes
            BetterClick(350, 97) ; click yes
            Sleep 200
            if(currentGameMode == "christmasEvent" || "default") {
                BetterClick(590, 15) ; click on P
            }
            
            break
        }
        /*else if (ok := FindText(&X, &Y, 694 - 150000, 66 - 150000, 694 + 150000, 66 + 150000, 0, 0, P2))
        {
            global StageStartTime := A_TickCount
            AddToLog("Loaded in late")
            Sleep 1000
            BetterClick(350, 103) ; click yes
            BetterClick(350, 100) ; click yes
            BetterClick(350, 97) ; click yes
            Sleep 200
            BetterClick(590, 15) ; click on P
            break
        }*/
        else if (ok := FindText(&X, &Y, 629 - 150000, 67 - 150000, 629 + 150000, 67 + 150000, 0, 0, P))
        {
            Sleep 10000
            if (ok := FindText(&X, &Y, 629 - 150000, 67 - 150000, 629 + 150000, 67 + 150000, 0, 0, P) and (ok != FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart))) {
                global StageStartTime := A_TickCount
                AddToLog("Loaded in late")
                if (hasReconnect == 1 && DisconnectCheckbox.Value == 1) {
                    sendRCWebhook()
                    hasReconnect := 0
                }
                Sleep 1000
                BetterClick(350, 103) ; click yes
                BetterClick(350, 100) ; click yes
                BetterClick(350, 97) ; click yes
                Sleep 200
                if(currentGameMode == "christmasEvent" || "default") {
                    BetterClick(590, 15) ; click on P
                }
                break
            }
        }

        Reconnect()
    }
    chat := ChatToSend.Value
    if (ChatStatusBox.Value = 1 && StrLen(chat) > 0) {
        AddToLog("Sending chat")
        SendChat()
    }
}

StartedLoop() {
    loop {
        Sleep 1000
        if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart))
        {
            continue
        }
        AddToLog("Game started")
        break
    }
}

LobbyLoop() {
    loop {
        Sleep 1000
        if (ok := FindText(&X, &Y, 746, 476, 862, 569, 0, 0, AreasText))
        {
            break
        }
        Reconnect()
    }
    AddToLog("Returning to lobby, going back to gamemode")
    return
}

CheckForLobbyButton() {
    if (ok := FindText(&X, &Y, 273, 103, 482, 214, 0, 0, LobbyText))
    {
        return true
    }
}

SendChat() {
    SendInput("/")
    Sleep 250
    chat := ChatToSend.Value
    if (ChatStatusBox.Value = 1 && StrLen(chat) > 0) {
        for char in StrSplit(chat) {
            Send(char)
            Sleep(Random(100, 200))  ; Optional delay between each keypress
        }
    }
    Sleep 1200
    SendInput("{Enter}")
    Sleep 250
    BetterClick(130, 43)
}

TPtoSpawn() {
    BetterClick(27, 574) ; setings
    Sleep 1000
    BetterClick(400, 287)
    Sleep 600
    loop 4 {
        Sleep 150
        SendInput("{WheelDown 1}") ; scroll
    }
    Sleep 600
    BetterClick(523, 271) ; tp to spawn
    Sleep 600
    BetterClick(582, 150) ; exit settings

}

DebugOCR() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    ocrResult := OCR.FromRect(266, 309, 603 - 266, 352 - 309, , 2)

    if ocrResult {
        BetterClick(414, 342)
        AddToLog("Captcha Detected: " ocrResult.Text)

        ; Clean up the captcha string
        captcha := StrReplace(ocrResult.Text, " ")  ; Remove spaces
        if (StrLen(captcha) <= 1 || RegExMatch(captcha, "[A-Za-z]")) {
            AddToLog("invalid captcha retrying")
        }

        ; Remove special characters like /, -, and .
        captcha := RegExReplace(captcha, "[/.\-_,]")

        ; Send each character
        Send(captcha)
        ;for char in StrSplit(captcha) {
        ;    Send(char)
        ;    Sleep(Random(25, 75))  ; Optional delay between each keypress
        ;}
    } else {
        AddToLog("NO CAPTCHA FOUND.")
    }
}

AntiCaptcha() {

    ; Perform OCR on the defined region directly
    ocrResult := OCR.FromRect(266, 309, 603 - 266, 352 - 309, , 2)

    ; Display OCR results
    Reconnect()
    if ocrResult {
        BetterClick(414, 342)
        AddToLog("Captcha Detected: " ocrResult.Text)

        ; Clean up the captcha string
        captcha := StrReplace(ocrResult.Text, " ")  ; Remove spaces
        if (StrLen(captcha) <= 1 || RegExMatch(captcha, "[A-Za-z]")) {
            AddToLog("invalid captcha retrying")
            BetterClick(584, 192) ; close captcha
            return
        }

        ; Remove special characters like /, -, and .
        captcha := RegExReplace(captcha, "[/.\-_,]")

        ; Send each character
        Send(captcha)
        ;for char in StrSplit(captcha) {
        ;    Send(char)
        ;    Sleep(Random(25, 75))  ; Optional delay between each keypress
        ;}
    } else {
        AddToLog("NO CAPTCHA FOUND.")
    }

    BetterClick(309, 386) ; select
    Sleep 1500
    BetterClick(383, 221)
    Sleep 500

    sleep 6000
    if (ok := FindText(&X, &Y, 10, 70, 350, 205, 0, 0, LoadingScreen)) {
        return
    }
    if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
        return
    }
    AddToLog("Walking to ensure the UI pops up again if it didnt matchmake")

    loop 2 {
        HoldKey("D", 400)
        HoldKey("A", 800)
        HoldKey("Space", 2000)
    }

    Sleep 1500
    if (ok := FindText(&X, &Y, 221, 206, 403, 355, 0, 0, MatchmakeUI))
    {
        AddToLog("Waiting for captcha cooldown then retrying")
        Sleep 6000
    }
    Reconnect()
    return
}


TapToMove(toggle) {

    SendInput("{Esc}")
    Sleep 1000
    BetterClick(246, 91)
    Sleep 500
    SendInput("{Down}")
    Sleep 100
    SendInput("{Down}")
    Sleep 500
    if (toggle) {
        SendInput("{Right}")
        Sleep 400
        SendInput("{Right}")
    }
    else {
        SendInput("{Left}")
        Sleep 400
        SendInput("{Left}")
    }
    Sleep 500
    SendInput("{Esc}")
    Sleep 1000
}

OnSpawnSetup() {
    SendInput ("{Tab}")
    LookDown()
    Sleep 200
    TPtoSpawn()
    Sleep 200
    TapToMove(true)
    Sleep 200
    AddToLog("Attempting to move to spot")
    loop 80 {
        Sleep 100

        if FindAndClickColor() {
            break
        }
    }
    Sleep 4000
    BetterClick(590, 15) ; click on P
    Sleep 1000
    TapToMove(false)

}

Reconnect() {
    ; Check for Disconnected Screen
    color := PixelGetColor(519, 329) ; Get color at (519, 329)
    global hasReconnect
    if (color = 0x393B3D) {
        AddToLog("Disconnected! Attempting to reconnect...")
        if (DisconnectCheckbox.Value = 1) {
            sendDCWebhook()
        }

        ; Use Roblox deep linking to reconnect
        Run("roblox://placeID=" 8304191830)
        Sleep 2000
        if WinExist(RobloxWindow) {
            WinMove(27, 15, 800, 600, RobloxWindow)
            WinActivate(RobloxWindow)
            Sleep 1000
        }
        loop {
            AddToLog("Reconnecting to Roblox...")
            Sleep 15000
            if (ok := FindText(&X, &Y, 746, 476, 862, 569, 0, 0, AreasText)) {
                AddToLog("Reconnected Succesfully!")
                hasReconnect := 1
                return GoToRaids() ; Check for challenges in the lobby
            }
            else {
                Reconnect()
            }
        }
    }
}

HoldKey(key, duration) {
    SendInput ("{" key "up}")
    ; go to teleporter
    Sleep 100
    SendInput ("{" key " down}")
    Sleep duration
    SendInput ("{" key " up}")
    KeyWait key ; Wait for "d" to be fully processed
}

cardSelector() {
    AddToLog("Picking card in priority order")
    if (ok := FindText(&X, &Y, 78, 182, 400, 451, 0, 0, UnitExistence)) {
        BetterClick(329, 184) ; close upg menu
        sleep 100
    }

    BetterClick(59, 572) ; Untarget Mouse
    sleep 500

    for index, priority in priorityOrder {
        if (!textCards.Has(priority)) {
            continue
        }
        if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, textCards.Get(priority))) {
            FindText().Click(cardX, cardY, 0)
            MouseMove 0, 10, 2, "R"
            Click 2
            sleep 1000
            MouseMove 0, 120, 2, "R"
            Click 2
            AddToLog(Format("Picked card: {}", priority))
            sleep 5000
            return
        }
    }
    AddToLog("Failed to pick a card")
}

;Added by @raynnpjl
cardSelectorBackup() {
    AddToLog("Picking card")
    if (ok := FindText(&X, &Y, 78, 182, 400, 451, 0, 0, UnitExistence)) {
        BetterClick(329, 184) ; close upg menu
        sleep 100
    }
    Click "256 334 0" ; Card Select 1
    sleep 100
    Click "403 334 0" ; Card Select 2
    sleep 100
    Click "547 334 0" ; Card Select 3
    sleep 100
    BetterClick(59, 572) ; Untarget Mouse
    sleep 500
    if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, new_path)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked new_path")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, shield)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked enemy shield")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, health)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked enemy health")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, regen)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked enemy regen")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, explosive_death)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked explosive_death")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, speed)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked enemy speed")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, range)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked range buff")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, attack)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked attack buff")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, cooldown)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked cooldown")
        sleep 5000
    }
    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, yen)) {
        FindText().Click(cardX, cardY, 0)
        MouseMove 0, 10, 2, "R"
        Click 2
        sleep 1000
        MouseMove 0, 120, 2, "R"
        Click 2
        AddToLog("Picked yen buff")
        sleep 5000
    }
    else {
        AddToLog("Failed to pick a card")
    }
}
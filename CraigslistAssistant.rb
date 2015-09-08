require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'rss'
require 'rails'
require 'watir-webdriver'
require 'csv'

class CraigslistAssistant

	CRAIGSLIST_LOCATION_CODES = {
														"auburn" => "aub",
														"bham" => "bhm",
														"dothan" => "dhn",
														"shoals" => "msl",
														"gadsden" => "anb",
														"huntsville" => "hsv",
														"mobile" => "mob",
														"montgomery" => "mgm",
														"tuscaloosa" => "tsc",
														"anchorage" => "anc",
														"fairbanks" => "fai",
														"kenai" => "ena",
														"juneau" => "jnu",
														"flagstaff" => "flg",
														"mohave" => "mhv",
														"phoenix" => "phx",
														"prescott" => "prc",
														"showlow" => "sow",
														"sierravista" => "fhu",
														"tucson" => "tus",
														"yuma" => "yum",
														"fayar" => "fyv",
														"fortsmith" => "fsm",
														"jonesboro" => "jbr",
														"littlerock" => "lit",
														"texarkana" => "txk",
														"bakersfield" => "bak",
														"chico" => "chc",
														"fresno" => "fre",
														"goldcountry" => "gld",
														"hanford" => "hnf",
														"humboldt" => "hmb",
														"imperial" => "imp",
														"inlandempire" => "inl",
														"losangeles" => "lax",
														"mendocino" => "mdo",
														"merced" => "mer",
														"modesto" => "mod",
														"monterey" => "mtb",
														"orangecounty" => "orc",
														"palmsprings" => "psp",
														"redding" => "rdd",
														"sacramento" => "sac",
														"sandiego" => "sdo",
														"sfbay" => "sfo",
														"slo" => "slo",
														"santabarbara" => "sba",
														"santamaria" => "smx",
														"siskiyou" => "ssk",
														"stockton" => "stk",
														"susanville" => "ssn",
														"ventura" => "oxr",
														"visalia" => "vis",
														"yubasutter" => "ybs",
														"boulder" => "bou",
														"cosprings" => "cos",
														"denver" => "den",
														"eastco" => "eco",
														"fortcollins" => "ftc",
														"rockies" => "rck",
														"pueblo" => "pub",
														"westslope" => "gjt",
														"newlondon" => "nlo",
														"hartford" => "htf",
														"newhaven" => "hvn",
														"nwct" => "nct",
														"delaware" => "dlw",
														"washingtondc" => "wdc",
														"miami" => "mia",
														"daytona" => "dab",
														"keys" => "key",
														"fortmyers" => "fmy",
														"gainesville" => "gnv",
														"cfl" => "cfl",
														"jacksonville" => "jax",
														"lakeland" => "lal",
														"lakecity" => "lcq",
														"ocala" => "oca",
														"okaloosa" => "vps",
														"orlando" => "orl",
														"panamacity" => "pfn",
														"pensacola" => "pns",
														"sarasota" => "srq",
														"spacecoast" => "mlb",
														"staugustine" => "ust",
														"tallahassee" => "tal",
														"tampa" => "tpa",
														"treasure" => "psl",
														"albanyga" => "aby",
														"athensga" => "ahn",
														"atlanta" => "atl",
														"augusta" => "aug",
														"brunswick" => "bwk",
														"columbusga" => "csg",
														"macon" => "mcn",
														"nwga" => "nwg",
														"savannah" => "sav",
														"statesboro" => "tbr",
														"valdosta" => "vld",
														"honolulu" => "hnl",
														"boise" => "boi",
														"eastidaho" => "eid",
														"lewiston" => "lws",
														"twinfalls" => "twf",
														"bn" => "bin",
														"chambana" => "chm",
														"chicago" => "chi",
														"decatur" => "dil",
														"lasalle" => "lsl",
														"mattoon" => "mto",
														"peoria" => "pia",
														"rockford" => "rfd",
														"carbondale" => "cbd",
														"springfieldil" => "spi",
														"quincy" => "qcy",
														"bloomington" => "bmg",
														"evansville" => "evv",
														"fortwayne" => "fwa",
														"indianapolis" => "ind",
														"kokomo" => "okk",
														"tippecanoe" => "laf",
														"muncie" => "mun",
														"richmondin" => "rin",
														"southbend" => "sbn",
														"terrehaute" => "tha",
														"ames" => "ame",
														"cedarrapids" => "ced",
														"desmoines" => "dsm",
														"dubuque" => "dbq",
														"fortdodge" => "ftd",
														"iowacity" => "iac",
														"masoncity" => "msc",
														"quadcities" => "mli",
														"siouxcity" => "sux",
														"ottumwa" => "otu",
														"waterloo" => "wlo",
														"lawrence" => "lwr",
														"ksu" => "mhk",
														"nwks" => "nwk",
														"salina" => "sns",
														"seks" => "sek",
														"swks" => "swk",
														"topeka" => "tpk",
														"wichita" => "wic",
														"bgky" => "blg",
														"eastky" => "eky",
														"lexington" => "lex",
														"louisville" => "lou",
														"owensboro" => "owb",
														"westky" => "wky",
														"batonrouge" => "btr",
														"cenla" => "aex",
														"houma" => "hum",
														"lafayette" => "lft",
														"lakecharles" => "lkc",
														"monroe" => "mlu",
														"neworleans" => "nor",
														"shreveport" => "shv",
														"maine" => "mne",
														"annapolis" => "anp",
														"baltimore" => "bal",
														"easternshore" => "esh",
														"frederick" => "fdk",
														"smd" => "smd",
														"westmd" => "wmd",
														"boston" => "bos",
														"capecod" => "cap",
														"southcoast" => "sma",
														"westernmass" => "wma",
														"worcester" => "wor",
														"annarbor" => "aaa",
														"battlecreek" => "btc",
														"centralmich" => "cmu",
														"detroit" => "det",
														"flint" => "fnt",
														"grandrapids" => "grr",
														"holland" => "hld",
														"jxn" => "jxn",
														"kalamazoo" => "kzo",
														"lansing" => "lan",
														"monroemi" => "mnr",
														"muskegon" => "mkg",
														"nmi" => "nmi",
														"porthuron" => "phn",
														"saginaw" => "mbn",
														"swmi" => "swm",
														"thumb" => "thb",
														"up" => "yup",
														"bemidji" => "bji",
														"brainerd" => "brd",
														"duluth" => "dlh",
														"mankato" => "mkt",
														"minneapolis" => "min",
														"rmn" => "rmn",
														"marshall" => "mml",
														"stcloud" => "stc",
														"gulfport" => "gpt",
														"hattiesburg" => "usm",
														"jackson" => "jan",
														"meridian" => "mei",
														"northmiss" => "nms",
														"natchez" => "hez",
														"columbiamo" => "cou",
														"joplin" => "jln",
														"kansascity" => "ksc",
														"kirksville" => "krk",
														"loz" => "loz",
														"semo" => "smo",
														"springfield" => "sgf",
														"stjoseph" => "stj",
														"stlouis" => "stl",
														"billings" => "bil",
														"bozeman" => "bzn",
														"butte" => "btm",
														"greatfalls" => "gtf",
														"helena" => "hln",
														"kalispell" => "fca",
														"missoula" => "mso",
														"montana" => "mnt",
														"grandisland" => "gil",
														"lincoln" => "lnk",
														"northplatte" => "lbf",
														"omaha" => "oma",
														"scottsbluff" => "bff",
														"elko" => "elk",
														"lasvegas" => "lvg",
														"reno" => "rno",
														"nh" => "nhm",
														"cnj" => "cnj",
														"jerseyshore" => "jys",
														"newjersey" => "njy",
														"southjersey" => "snj",
														"albuquerque" => "abq",
														"clovis" => "cvn",
														"farmington" => "fnm",
														"lascruces" => "lcr",
														"roswell" => "row",
														"santafe" => "saf",
														"albany" => "alb",
														"binghamton" => "bgm",
														"buffalo" => "buf",
														"catskills" => "cat",
														"chautauqua" => "chq",
														"elmira" => "elm",
														"fingerlakes" => "fgl",
														"glensfalls" => "gfl",
														"hudsonvalley" => "hud",
														"ithaca" => "ith",
														"longisland" => "isp",
														"newyork" => "nyc",
														"oneonta" => "onh",
														"plattsburgh" => "plb",
														"potsdam" => "ptd",
														"rochester" => "rcs",
														"syracuse" => "syr",
														"twintiers" => "tts",
														"utica" => "uti",
														"watertown" => "wtn",
														"asheville" => "ash",
														"boone" => "bnc",
														"charlotte" => "cha",
														"eastnc" => "enc",
														"fayetteville" => "fay",
														"greensboro" => "gbo",
														"hickory" => "hky",
														"onslow" => "oaj",
														"outerbanks" => "obx",
														"raleigh" => "ral",
														"wilmington" => "wnc",
														"winstonsalem" => "wsl",
														"bismarck" => "bis",
														"fargo" => "far",
														"grandforks" => "gfk",
														"nd" => "ndk",
														"akroncanton" => "cak",
														"ashtabula" => "jfn",
														"athensohio" => "ohu",
														"chillicothe" => "chl",
														"cincinnati" => "cin",
														"cleveland" => "cle",
														"columbus" => "col",
														"dayton" => "day",
														"limaohio" => "lma",
														"mansfield" => "mfd",
														"sandusky" => "sky",
														"toledo" => "tol",
														"tuscarawas" => "nph",
														"youngstown" => "yng",
														"zanesville" => "zvl",
														"lawton" => "law",
														"enid" => "end",
														"oklahomacity" => "okc",
														"stillwater" => "osu",
														"tulsa" => "tul",
														"bend" => "bnd",
														"corvallis" => "crv",
														"eastoregon" => "eor",
														"eugene" => "eug",
														"klamath" => "klf",
														"medford" => "mfr",
														"oregoncoast" => "cor",
														"portland" => "pdx",
														"roseburg" => "rbg",
														"salem" => "sle",
														"altoona" => "aoo",
														"chambersburg" => "cbg",
														"erie" => "eri",
														"harrisburg" => "hrs",
														"lancaster" => "lns",
														"allentown" => "alt",
														"meadville" => "mdv",
														"philadelphia" => "phi",
														"pittsburgh" => "pit",
														"poconos" => "poc",
														"reading" => "rea",
														"scranton" => "avp",
														"pennstate" => "psu",
														"williamsport" => "wpt",
														"york" => "yrk",
														"providence" => "prv",
														"charleston" => "chs",
														"columbia" => "cae",
														"florencesc" => "flo",
														"greenville" => "gsp",
														"hiltonhead" => "hii",
														"myrtlebeach" => "myr",
														"nesd" => "abr",
														"csd" => "csd",
														"rapidcity" => "rap",
														"siouxfalls" => "fsd",
														"sd" => "sdk",
														"chattanooga" => "cht",
														"clarksville" => "ckv",
														"cookeville" => "coo",
														"jacksontn" => "jxt",
														"knoxville" => "knx",
														"memphis" => "mem",
														"nashville" => "nsh",
														"tricities" => "tri",
														"abilene" => "abi",
														"amarillo" => "ama",
														"austin" => "aus",
														"beaumont" => "bpt",
														"brownsville" => "bro",
														"collegestation" => "cst",
														"corpuschristi" => "crp",
														"dallas" => "dal",
														"nacogdoches" => "och",
														"delrio" => "drt",
														"elpaso" => "elp",
														"galveston" => "gls",
														"houston" => "hou",
														"killeen" => "grk",
														"laredo" => "lrd",
														"lubbock" => "lbb",
														"mcallen" => "mca",
														"odessa" => "odm",
														"sanangelo" => "sjt",
														"sanantonio" => "sat",
														"sanmarcos" => "tsu",
														"bigbend" => "wtx",
														"texoma" => "txm",
														"easttexas" => "etx",
														"victoriatx" => "vtx",
														"waco" => "wco",
														"wichitafalls" => "wtf",
														"logan" => "lgu",
														"ogden" => "ogd",
														"provo" => "pvu",
														"saltlakecity" => "slc",
														"stgeorge" => "stg",
														"burlington" => "brl",
														"charlottesville" => "uva",
														"danville" => "dnv",
														"fredericksburg" => "ezf",
														"norfolk" => "nfk",
														"harrisonburg" => "shd",
														"lynchburg" => "lyn",
														"blacksburg" => "vpi",
														"richmond" => "ric",
														"roanoke" => "roa",
														"swva" => "vaw",
														"winchester" => "okv",
														"bellingham" => "bli",
														"kpr" => "kpr",
														"moseslake" => "mlk",
														"olympic" => "olp",
														"pullman" => "plm",
														"seattle" => "sea",
														"skagit" => "mvw",
														"spokane" => "spk",
														"wenatchee" => "wen",
														"yakima" => "yak",
														"charlestonwv" => "crw",
														"martinsburg" => "ewv",
														"huntington" => "hts",
														"morgantown" => "wvu",
														"wheeling" => "whl",
														"parkersburg" => "pkb",
														"swv" => "swv",
														"wv" => "wva",
														"appleton" => "app",
														"eauclaire" => "eau",
														"greenbay" => "grb",
														"janesville" => "jvl",
														"racine" => "rac",
														"lacrosse" => "lse",
														"madison" => "mad",
														"milwaukee" => "mil",
														"northernwi" => "nwi",
														"sheboygan" => "sbm",
														"wausau" => "wau",
														"wyoming" => "wyo",
														"micronesia" => "gum",
														"puertorico" => "pri",
														"virgin" => "vrg"
														}

	def initialize (opts ={})
		opts = { links_csv_file: "links.csv",
		  			 output_csv_file: "output.csv"}.merge(opts)
		@links_csv_file = opts[:links_csv_file]
		@output_csv_file = opts[:output_csv_file]
	end
	
	def present_links
		# Open a browser
		browser = Watir::Browser.new
		# Open CSV file
		ads_info = get_csv_data(@links_csv_file)
		# Create a fresh output file
		create_output_file

		puts "Total Ads: #{ads_info.length}"
		# Go through each link
		ads_info.each_with_index do |ad_info, index|
			# Present the link on the page
			browser.goto ad_info['Link']
			# Wait for user input - Y = Yes, Anything Else = No
			puts "Get this email? "
			input = gets.chomp
			# If user presses Y, 
			if input.downcase == "y"
				#	Get the email address from the page (if available)
				email = extract_email(ad_info['Link'])
				#	Save the CL ad info to a file
				write_email(ad_info, email)
			end
			puts "Remaining Ads: #{ads_info.length - index - 1}"
		end
		browser.close
	end

	def get_csv_data(file_name)
		CSV.read(file_name, :headers => true, :encoding => 'windows-1251:utf-8') 
	end

	def extract_email(craigslist_ad_link)
		
		post_location = craigslist_ad_link[/http:\/\/([^\.]+)/,1]
		post_id = craigslist_ad_link[/\/(\d+).html/,1]
		job_type = craigslist_ad_link[/([a-z]{3})\/(\d+)/,1]
		referer = craigslist_ad_link

		contact_info_url = "http://#{post_location}.craigslist.org/reply/#{CRAIGSLIST_LOCATION_CODES[post_location]}/#{job_type}/#{post_id}"
		puts "Fetching #{contact_info_url}"

		agent = Mechanize.new
		agent.user_agent_alias = 'Mac Firefox'
	  agent.request_headers = {
	  	"X-Requested-With" => "XMLHttpRequest",
			"Host" => "#{post_location}.craigslist.org",
			"Accept" => "text/html, */*; q=0.01",
			"Accept-Language" => "en-US,en;q=0.5",
			"Accept-Encoding" => "gzip, deflate",
			"Accept-Language" => "en-US,en;q=0.5",
			"Referer" => referer,
			"Connection" => "keep-alive"
	  }
	  cookie = Mechanize::Cookie.new :domain => '.craigslist.org', :name => "cl_b", :value => "fOAmTbDZ5BGxT5JRDXvM6gUngSs", :path => '/', :expires => (Date.today + 1).to_s
	  agent.cookie_jar << cookie
	  cookie = Mechanize::Cookie.new :domain => '.craigslist.org', :name => "cl_def_lang", :value => "en", :path => '/', :expires => (Date.today + 1).to_s
	  agent.cookie_jar << cookie
	  cookie = Mechanize::Cookie.new :domain => '.craigslist.org', :name => "cl_def_hp", :value => "#{post_location}", :path => '/', :expires => (Date.today + 1).to_s
	  agent.cookie_jar << cookie
	  cookie = Mechanize::Cookie.new :domain => '.craigslist.org', :name => "cl_tocmode", :value => "ggg%3Alist", :path => '/', :expires => (Date.today + 1).to_s
		agent.cookie_jar << cookie
		
		begin
			page = agent.get(contact_info_url)
			page.search(".anonemail").text
		rescue Exception => msg
			puts "Error: #{msg}"
			puts "\tYou may have been blocked."
			puts "\tChange IPs and push any key to try again"
			gets
			retry
		end

		# begin
		# 	browser.goto url
		# 	browser.button(:class => 'reply_button').click
			
		# 	sleep 0.3
			
		# 	email = browser.divs(:class => "anonemail")[0].text + "\n"
		# rescue Exception => msg 
		# 	puts "Error retrieving email at #{url}"
		# 	puts "Error Message: #{msg}"
		# 	return ""
		# else
		# 	return email.to_s
		# end
	end

	def write_email(ad_info, email)
		if !email.nil?
			CSV.open(@output_csv_file,"a") do |csv|
			 	csv << [ ad_info['Date'],
			 					 ad_info['Location'],
			 					 email,
			 					 ad_info['Title'],
			 					 ad_info['Link']
			 					]
			end
		end
	end

	def create_output_file
		headers = get_csv_data(@links_csv_file).headers
		CSV.open(@output_csv_file,"w") do |csv|
			 	csv << headers
		end
	end
end
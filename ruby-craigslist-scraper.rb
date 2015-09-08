# How to get this to work:
#   1) Go to Craigslist.org and find a search query you like in a category.
#      For example: go to Gigs, filter "paid" and type "Website"
#   2) Copy the latter part of the URL.  Everything after craigslist.org/.
# 		 NOTE: Make sure to leave in &format=rss
#   3) Paste that part of the URL after "link['href']" in the script below
#   4) Run the script.  This creates output.txt with all the location URLs
#   5) Paste the text in output.txt into this url:
#      http://reader.feedshow.com/goodies/opml/OPMLBuilder-create-opml-from-rss-list.php
#   6) Save the resulting file as an XML file using CTRL+S in browser.
#   7) Take the file (which is techincally an OPML) and import it into Feedly
#      NOTE: Before you do this, you may want to change the text "Main Folder"
#            to something else that will be the category of the Feedly feed.
#   8) Now you have a feed of all postings in a category!
#
# Use this script if you ever need to up

require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'rss'
require 'rails'
require 'watir-webdriver'
require 'csv'

PAGE_URL = "http://craigslist.org/about/sites"

# CL Location Name => Location Code
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

def fetch_data
	agent = Mechanize.new

	previous_date = "April 2, 2015 - 12:17"

	puts "\nFetching #{PAGE_URL}"
	page = agent.get(PAGE_URL)


	links = "<html><body>"

	 job_types = [ "cpg", 
	 						   "web", 
	 						   "eng", 
							   "mar"
							]
	keywords = ["website", "developer", "wordpress"]
	negative_keywords = ["ios", 
													 "iphone", 
													 "android", 
													 "app", 
													 "magento", 
													 "on site", 
													 "onsite", 
													 "on-site", 
													 "in house", 
													 "tight budget", 
													 "take surveys", 
													 "earn money", 
													 "cash",
													 "intern",
													 "part time"]

	request_counter = 0 #counter to keep track of RSS requests to see if I notice how many is a problem...

	job_types.each_with_index do |job_type, index|

		csv = "\"Date\",\"Location\",\"Email\",\"Title\",\"Link\"\n"

		links_file_name = "links-#{job_type}.csv"

		all_location_links = page.search(".colmask")[0].search("a")

		keywords.each do |kw|
			all_location_links.each_with_index do |link, index| # Only goes through the first colmask element - which is the US
				location = link['href'].scan( /\/\/(.+)\.craigslist/).last.first # Extract location name
				puts "Fetching #{location} links after #{previous_date} for #{job_type}..."
				
				neg_kw_str = ""
				negative_keywords.each do |neg_kw|
					neg_kw_str << "+-%22#{neg_kw}%22".gsub(" ", "+")
				end

				rss_link = link['href'] + "/search/#{job_type}?is_paid=yes&query=#{kw}#{neg_kw_str}&format=rss" # computer gigs
				puts "  Fetching #{kw} links for #{location}"

				begin
					rss = RSS::Parser.parse(rss_link, false)
				rescue 
					puts "Error reading RSS for #{location}"
					puts "  Last Successful Request: #{request_counter}"
				else
					rss.items.each do |item|
						unless item.date < Time.parse(previous_date)
							formatted_date = item.date.strftime("%B %-d, %Y - %H:%M")
							# Sanitize Title
							item.title = item.title.encode('UTF-8', :invalid => :replace, :undef => :replace).gsub(/[^[A-Za-z0-9$()\/ ]]/, "")
							links += "<p><i>#{formatted_date}</i> - #{location} - <a href=\"#{item.link}\">#{item.title}</a></p>"
							csv += "\"#{formatted_date}\",\"#{location}\",\"\",\"#{item.title}\",\"#{item.link}\"\n"
						end
					end
					request_counter += 1
					puts "Successful Request: #{request_counter}"
				end
				puts "Done fetching #{location} links for #{job_type}!"
			end
		end
		links += "</body></html>"
		File.write('cl_links.html', links)
		File.write(links_file_name, csv)
	end
end

def extract_email(post_location, job_type, post_id, referer)
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
		"Referer" => "#{referer}",
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
	
	page = agent.get(contact_info_url)

	page.search(".anonemail").text

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

def extract_emails
	#browser = Watir::Browser.new :firefox

	job_types = [ "cpg", 
							  "web",
							  "eng", 
							  "mar"
							]

	total_successes = 0
	job_types.each do |job_type|
		links_csv = CSV.read("links-#{job_type}.csv", :headers => true, :encoding => 'windows-1251:utf-8') 

		# Overwrite old file and put headers
		CSV.open("emails-#{job_type}.csv","wb") do |csv|
		 	csv << links_csv.headers
		end

		links_csv.each_with_index do |row, index|
			post_location = row['Link'][/http:\/\/([^\.]+)/,1]
			post_id = row['Link'][/\/(\d+).html/,1]
			begin 
				email = extract_email(post_location, job_type, post_id,row['Link'])
				total_successes += 1
			rescue Exception => msg
				puts "#{msg}"
				puts "Total Successes Count: #{total_successes}"
				email = ""
			end
			CSV.open("emails-#{job_type}.csv","a") do |csv|
			 	csv << [ row['Date'],
			 					 row['Location'],
			 					 email,
			 					 row['Title'],
			 					 row['Link']
			 					]

			 puts "Total Successes: #{total_successes}"
			 if total_successes % 50 == 0
			 		puts "Change IP to ensure no blocking.  Press Enter when done."
					say_string = "Change IP NOW NOW NOW!"
					`say "#{say_string}"`
					gets
				end
			end
		end
	end	
end

#Remove those who have negative keywords
def remove_negatives(links_csv_file)
	negative_keywords = File.readlines("negative-keywords.txt").each { |line| line.strip! }
	csv_data = CSV.read(links_csv_file, :headers => true, :encoding => 'windows-1251:utf-8') 
	output_file = links_csv_file

	CSV.open(output_file,"w") do |csv|
		 	csv << csv_data.headers
	end

	csv_data.each do |row|
		unless negative_keywords.any? { |negative_keyword| row['Title'].downcase.include?(negative_keyword.downcase)}
			CSV.open(output_file,"a") do |csv|
			 	csv << [ row['Date'],
			 					 row['Location'],
			 					 row['Email'],
			 					 row['Title'],
			 					 row['Link']
			 					]
			end
		end
	end
end

def remove_duplicates(file_name)
	# Load table with headers to get the dupe row index
	table = CSV.read(file_name, :headers => true)
	duplicate_header_row = 'Title'
	duplicate_header_row_index = table.headers.find_index(duplicate_header_row)
	# Reload the table without headers to access it more easily to remove dupes
	table = CSV.read(file_name)

	CSV.open(file_name, 'wb') do |csv|
		table.uniq { |row| row[duplicate_header_row_index] }.each do |row|
			csv << row
		end
	end
end



start_time = Time.now
puts "Starting Script..."

fetch_data
#extract_emails
remove_duplicates("links-cpg.csv")
remove_negatives("links-cpg.csv")
puts "Finished cpg"
remove_duplicates("links-eng.csv")
remove_negatives("links-eng.csv")
puts "Finished eng"
remove_duplicates("links-web.csv")
remove_negatives("links-web.csv")
puts "Finished web"
remove_duplicates("links-mar.csv")
remove_negatives("links-mar.csv")
puts "Finished mar"

say_string = "All Done!"
`say "#{say_string}"`
puts "Script Complete!"
puts "Time elapsed: #{Time.now - start_time} seconds"
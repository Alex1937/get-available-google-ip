#!/bin/bash

begintime=`date +%s`
if [ "$USER" != "root" ]
then
    echo "Please use root user run this script!!!"
    exit
fi

#Static resource
JSONDATA="/tmp/google.json"
GETIPLIST="/tmp/get.ip"
AVAILABLEIP="/tmp/available.ip"
INSERTTIMEINTOIP="/tmp/settime.ip"
SORTEDIPBYSPPED="speed.ip"

#Init all files
rm -f $JSONDATA
rm -f $GETIPLIST
rm -f $AVAILABLEIP
rm -f $INSERTTIMEINTOIP
rm -f $SORTEDIPBYSPPED

#Get Json format data from www.ipip.net
curl -s "http://www.ipip.net/ping.php?a=send&host=www.google.com&area=other" > $JSONDATA

#Analysis data on Macbook
sed -e 's/ /\'$'\n/g' $JSONDATA | egrep "^((25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)\.){3}(25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|[1-9])$" |uniq > $GETIPLIST

for ip in `cat $GETIPLIST`
do
    #set curl timeout for filter bad ip
    headcode=`curl -o /dev/null -s -m 2 --connect-timeout 2 -w %{http_code} $ip`
    if [ "$headcode" = "200" ]
    then 
        echo $ip >> $AVAILABLEIP
    fi
done

for realip in `cat $AVAILABLEIP`
do
    totaltime=`curl -o /dev/null -s --connect-timeout 5 -w %{time_total} $realip`
    echo $totaltime $realip >> $INSERTTIMEINTOIP
done

#Sum of the IPs
count=`wc -l $INSERTTIMEINTOIP |awk '{print $1}'`

#Get the fastest ip 
sort $INSERTTIMEINTOIP> $SORTEDIPBYSPPED
fastip=`awk 'NR==1{print $2}' $SORTEDIPBYSPPED`

domain="0.docs.google.com 0.drive.google.com 1.docs.google.com 1.drive.google.com 10.docs.google.com 10.drive.google.com 11.docs.google.com 11.drive.google.com 12.docs.google.com 12.drive.google.com 13.docs.google.com 13.drive.google.com 14.docs.google.com 14.drive.google.com 15.docs.google.com 15.drive.google.com 16.docs.google.com 16.drive.google.com 2.docs.google.com 2.drive.google.com 3.docs.google.com 3.drive.google.com 4.docs.google.com 4.drive.google.com 5.docs.google.com 5.drive.google.com 6.docs.google.com 6.drive.google.com 7.docs.google.com 7.drive.google.com 8.docs.google.com 8.drive.google.com 9.docs.google.com 9.drive.google.com accounts.google.com accounts.l.google.com answers.google.com apis.google.com appengine.google.com apps.google.com appspot.l.google.com bks0.books.google.com bks1.books.google.com bks10.books.google.com bks2.books.google.com bks3.books.google.com bks4.books.google.com bks5.books.google.com bks6.books.google.com bks7.books.google.com bks8.books.google.com bks9.books.google.com blogsearch.google.com books.google.com browserchannel-docs.l.google.com browserchannel-spreadsheets.l.google.com browsersync.google.com browsersync.l.google.com buzz.google.com cache.l.google.com cache.pack.google.com calendar.google.com cbk0.google.com cbk1.google.com cbk2.google.com cbk3.google.com cbks0.google.com cbks1.google.com cbks2.google.com cbks3.google.com chart.apis.google.com chatenabled.mail.google.com checkout.google.com checkout.l.google.com chrome.google.com clients.l.google.com clients1.google.com clients2.google.com clients3.google.com clients4.google.com clients5.google.com clients6.google.com clients7.google.com code.google.com code.l.google.com csi.l.google.com desktop.google.com desktop.l.google.com desktop2.google.com developers.google.com ditu.google.com dl.google.com dl.l.google.com dl-ssl.google.com docs.google.com docs0.google.com docs1.google.com docs2.google.com docs3.google.com docs4.google.com docs5.google.com docs6.google.com docs7.google.com docs8.google.com docs9.google.com drive.google.com drive0.google.com drive1.google.com drive2.google.com drive3.google.com drive4.google.com drive5.google.com drive6.google.com drive7.google.com drive8.google.com drive9.google.com earth.google.com encrypted.google.com encrypted-tbn.l.google.com encrypted-tbn0.google.com encrypted-tbn1.google.com encrypted-tbn2.google.com encrypted-tbn3.google.com feedburner.google.com feedproxy.google.com filetransferenabled.mail.google.com finance.google.com fusion.google.com geoauth.google.com gg.google.com ghs.google.com ghs.l.google.com ghs46.google.com ghs46.l.google.com google.com googleapis.l.google.com googleapis-ajax.google.com googleapis-ajax.l.google.com googlecode.l.google.com google-public-dns-a.google.com google-public-dns-b.google.com goto.google.com groups.google.com groups.l.google.com groups-beta.google.com gxc.google.com id.google.com id.l.google.com images.google.com images.l.google.com investor.google.com jmt0.google.com kh.google.com kh.l.google.com khm.google.com khm.l.google.com khm0.google.com khm1.google.com khm2.google.com khm3.google.com khmdb.google.com khms.google.com khms.l.google.com khms0.google.com khms1.google.com khms2.google.com khms3.google.com labs.google.com large-uploads.l.google.com lh2.google.com lh2.l.google.com lh3.google.com lh4.google.com lh5.google.com lh6.google.com linkhelp.clients.google.com local.google.com m.google.com mail.google.com map.google.com maps.google.com maps.l.google.com maps-api-ssl.google.com mars.google.com mobile.l.google.com mobile-gtalk.l.google.com mobilemaps.clients.google.com mt.google.com mt.l.google.com mt0.google.com mt1.google.com mt2.google.com mt3.google.com mtalk.google.com mts.google.com mts.l.google.com mts0.google.com mts1.google.com mts2.google.com mts3.google.com music.google.com music-streaming.l.google.com mw1.google.com mw2.google.com news.google.com news.l.google.com pack.google.com photos.google.com photos-ugc.l.google.com picasa.google.com picasaweb.google.com picasaweb.l.google.com places.google.com play.google.com productforums.google.com profiles.google.com reader.google.com safebrowsing.cache.l.google.com safebrowsing.clients.google.com safebrowsing.google.com safebrowsing-cache.google.com sandbox.google.com sb.google.com sb.l.google.com sb-ssl.google.com sb-ssl.l.google.com scholar.google.com scholar.l.google.com script.google.com services.google.com sites.google.com sketchup.google.com sketchup.l.google.com spreadsheet.google.com spreadsheets.google.com spreadsheets.l.google.com spreadsheets0.google.com spreadsheets1.google.com spreadsheets2.google.com spreadsheets3.google.com spreadsheets4.google.com spreadsheets5.google.com spreadsheets6.google.com spreadsheets7.google.com spreadsheets8.google.com spreadsheets9.google.com spreadsheets-china.l.google.com suggestqueries.google.com suggestqueries.l.google.com support.google.com talk.google.com talkgadget.google.com tbn0.google.com tbn1.google.com tbn2.google.com tbn3.google.com toolbar.google.com toolbarqueries.clients.google.com toolbarqueries.google.com toolbarqueries.l.google.com tools.google.com tools.l.google.com translate.google.com trends.google.com upload.docs.google.com upload.drive.google.com uploads.code.google.com uploadsj.clients.google.com v3.cache1.c.docs.google.com video.google.com video-stats.l.google.com voice.google.com wallet.google.com wifi.google.com wifi.l.google.com wire.l.google.com writely.google.com writely.l.google.com writely-china.l.google.com writely-com.l.google.com www.google.com www.l.google.com www2.l.google.com www3.l.google.com www4.l.google.com ytstatic.l.google.com 0-open-opensocial.googleusercontent.com 0-focus-opensocial.googleusercontent.com 1-focus-opensocial.googleusercontent.com 1-open-opensocial.googleusercontent.com 1-ps.googleusercontent.com 2-focus-opensocial.googleusercontent.com 2-open-opensocial.googleusercontent.com 2-ps.googleusercontent.com 3-focus-opensocial.googleusercontent.com 3-ps.googleusercontent.com 3-open-opensocial.googleusercontent.com 4-ps.googleusercontent.com a-oz-opensocial.googleusercontent.com blogger.googleusercontent.com clients1.googleusercontent.com clients2.googleusercontent.com clients3.googleusercontent.com clients4.googleusercontent.com clients5.googleusercontent.com clients6.googleusercontent.com clients7.googleusercontent.com feedback.googleusercontent.com googlehosted.l.googleusercontent.com gp0.googleusercontent.com gp1.googleusercontent.com gp2.googleusercontent.com gp3.googleusercontent.com gp4.googleusercontent.com gp5.googleusercontent.com gp6.googleusercontent.com images1-focus-opensocial.googleusercontent.com images2-focus-opensocial.googleusercontent.com images3-focus-opensocial.googleusercontent.com images4-focus-opensocial.googleusercontent.com images5-focus-opensocial.googleusercontent.com images6-focus-opensocial.googleusercontent.com images7-focus-opensocial.googleusercontent.com images8-focus-opensocial.googleusercontent.com images9-focus-opensocial.googleusercontent.com images-docs-opensocial.googleusercontent.com images-oz-opensocial.googleusercontent.com lh1.googleusercontent.com lh2.googleusercontent.com lh3.googleusercontent.com lh4.googleusercontent.com lh5.googleusercontent.com lh6.googleusercontent.com mail-attachment.googleusercontent.com music.googleusercontent.com music-onebox.googleusercontent.com oauth.googleusercontent.com s1.googleusercontent.com s2.googleusercontent.com s3.googleusercontent.com s4.googleusercontent.com s5.googleusercontent.com s6.googleusercontent.com spreadsheets-opensocial.googleusercontent.com static.googleusercontent.com t.doc-0-0-sj.sj.googleusercontent.com themes.googleusercontent.com translate.googleusercontent.com webcache.googleusercontent.com www.googleusercontent.com www-calendar-opensocial.googleusercontent.com www-fc-opensocial.googleusercontent.com www-focus-opensocial.googleusercontent.com www-gm-opensocial.googleusercontent.com www-kix-opensocial.googleusercontent.com www-open-opensocial.googleusercontent.com www-opensocial.googleusercontent.com www-opensocial-sandbox.googleusercontent.com www-oz-opensocial.googleusercontent.com csi.gstatic.com g0.gstatic.com g1.gstatic.com g2.gstatic.com g3.gstatic.com maps.gstatic.com mt0.gstatic.com mt1.gstatic.com mt2.gstatic.com mt3.gstatic.com mt4.gstatic.com mt5.gstatic.com mt6.gstatic.com mt7.gstatic.com ssl.gstatic.com t0.gstatic.com t1.gstatic.com t2.gstatic.com t3.gstatic.com www.gstatic.com lh1.ggpht.com lh2.ggpht.com lh3.ggpht.com lh4.ggpht.com lh5.ggpht.com lh6.ggpht.com nt0.ggpht.com nt1.ggpht.com nt2.ggpht.com nt3.ggpht.com nt4.ggpht.com nt5.ggpht.com appspot.com www.appspot.com ajax.googleapis.com chart.googleapis.com fonts.googleapis.com maps.googleapis.com mt0.googleapis.com mt1.googleapis.com mt2.googleapis.com mt3.googleapis.com redirector-bigcache.googleapis.com translate.googleapis.com www.googleapis.com autoproxy-gfwlist.googlecode.com chromium.googlecode.com closure-library.googlecode.com earth-api-samples.googlecode.com gmaps-samples-flash.googlecode.com google-code-feed-gadget.googlecode.com blogsearch.google.cn ditu.google.cn gg.google.cn id.google.cn maps.gstatic.cn m.google.cn mt.google.cn mt0.google.cn mt1.google.cn mt2.google.cn mt3.google.cn news.google.cn scholar.google.cn translate.google.cn www.google.cn www.gstatic.cn accounts.google.com.hk blogsearch.google.com.hk books.google.com.hk clients1.google.com.hk desktop.google.com.hk encrypted.google.com.hk groups.google.com.hk gxc.google.com.hk id.google.com.hk images.google.com.hk m.google.com.hk maps.google.com.hk news.google.com.hk picasaweb.google.com.hk plus.url.google.com.hk scholar.google.com.h.com fonts.googleapis.com maps.googleapis.com mt0.hk translate.google.com.hk translate.google.com.hk wenda.google.com.hk www.google.com.hk accounts.blogger.com android.googlesource.com auth.keyhole.com chrome.angrybirds.com developer.android.com domains.googlesyndication.com earthengine.googlelabs.com feeds.feedburner.com g.co goo.gl listen.googlelabs.com m.googlemail.com market.android.com ngrams.googlelabs.com panoramio.com smarthosts.googlecode.com ssl.google-analytics.com static.panoramio.com www.blogger.com www.googleadservgle.cn mt3.google.cn news.google.cn scholar.googleom www.googlesource.com www.panoramio.com plus.google.com plus.url.google.com plusone.google.com www.youtube.com source.android.com www.android.com"
#purge hosts file
echo "">/etc/hosts

for name in $domain
do
    echo $fastip $name >> /etc/hosts
done

#rm -f $JSONDATA
#rm -f $GETIPLIST
#rm -f $AVAILABLEIP
#rm -f $INSERTTIMEINTOIP

echo ""
echo "Congratulations that you get $count IPs available for google services !!!"
echo
echo "We have picked up the fastest one for you,FastestIP:$fastip "
echo
echo "Enjoy Googling!"
echo

#get time cost
endtime=`date +%s`
duration=$(($endtime-$begintime))
echo "Cost you $((duration/60)) mins!"
echo

#!/bin/bash
unzip klix-wordpress-theme.zip 
mv klix.zip zipfiles/
unzip luris-wordpress-theme.zip 
mv iuris.zip zipfiles/
unzip maggie-news-magazine-wordpress-theme.zip 
cd maggie
ll
cd maggie-theme/
ll
cd maggie/
ll
cd ..
cp maggie-news-magazine-wordpress-theme.zip zipfiles/
unzip marea-holiday-travel-wordpress-theme.zip 
mv marea.zip zipfiles/
unzip mh-magazine-wordpress-theme-theme-files.zip 
cd mh_magazine/
ll
cd ..
cp mh-magazine-wordpress-theme-theme-files.zip zipfiles/
unzip nectar-a-responsive-wordpress-theme.zip 
ll
cd Nectar\ -\ Theme\ and\ Documentation\ -\ v1.2.0/
ll
mv nectar-theme.zip ../zipfiles/
cd ..
ll
unzip new-commerce-responsive-e-commerce-theme.zip 
ll
mv new-commerce3.0.zip zipfiles/
unzip observer-multipurpose-news-magazine-wordpress-theme-theme-files.zip 
cd Observer/
ll
cd ..
cp observer-multipurpose-news-magazine-wordpress-theme-theme-files.zip zipfiles/
ll
unzip qualeb-responsive-wordpress-theme-for-agencies.zip 
cd Qualeb\ -\ Responsive\ Business\ \&\ Agency\ WordPress\ Theme/
ll
cp qualeb.zip ../zipfiles/
cd ..
unzip rustik-minimalist-e-commerce-ready-theme.zip 
cd Rustik_WP_WOO_WESMASHEDIT/
ll
cd Theme/
ll
mv rustik.zip ../../zipfiles/
cd ..
ll
unzip seaview-a-responsive-wordpress-real-estate-theme.zip 
mv seaview.zip zipfiles/
unzip take-a-break-restaurant-one-page-wordpress-theme-2-theme-files.zip
mv takeabreak.zip zipfiles/
unzip uplift-church-event-wordpress-theme-responsive-theme-files.zip 
cd uplift
ll
cd theme/
ll
cd ..
cp uplift-church-event-wordpress-theme-responsive-theme-files.zip zipfiles/
ll
find . -user root -execdir rm -rf {} +

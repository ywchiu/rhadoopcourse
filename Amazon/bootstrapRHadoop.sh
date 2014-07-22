echo 'install.packages(c(codetools, R, Rcpp, RJSONIO, bitops, digest, functional, stringr, plyr, reshape2, rJava, caTools), repos=httpcran.us.r-project.org)'  homehadoopinstallPackage.R
sudo Rscript homehadoopinstallPackage.R
wget --no-check-certificate httpsraw.githubusercontent.comRevolutionAnalyticsrmr2masterbuildrmr2_3.1.2.tar.gz
sudo R CMD INSTALL rmr2_3.1.2.tar.gz
wget --no-check-certificate httpsraw.github.comRevolutionAnalyticsrhdfsmasterbuildrhdfs_1.0.8.tar.gz
sudo HADOOP_CMD=homehadoopbinhadoop R CMD INSTALL rhdfs_1.0.8.tar.gz
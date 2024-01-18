export PATH=$PATH:~/.local/share/coursier/bin
cd ./lila-ws/
nohup sbt run -Dcsrf.origin=http://localhost:9663 -Dconfig.file=/lila/lila-ws/ws-config.conf & 
cd /lila/
cp conf/application.conf.default conf/application.conf
sbt -J-Xmx4g compile run ./lila

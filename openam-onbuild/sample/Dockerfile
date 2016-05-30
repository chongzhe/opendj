FROM forgerock/openam-onbuild


#ADD openam.properties /var/tmp/openam.properties
#ADD env.sh /var/tmp/env.sh
#ADD config.sh /var/tmp
#ADD ssoadm.txt /var/tmp/ssoadm.txt
#ADD ssoadm /root/admintools/ssoadm
#
#RUN /var/tmp/config.sh

#
#RUN /usr/local/tomcat/bin/catalina.sh start  \
#      && . /var/tmp/env.sh \
#      && cd /var/tmp/ssoconfig \
#      && echo "running openam configurator" \
#      && sleep 10 \
#      && echo "127.0.0.2  $HOSTNAME" >> /etc/hosts \
#      && echo "about to run configurator" \
#      && java -jar openam-configurator-tool*.jar -f /var/tmp/openam.properties \
#      && /usr/local/tomcat/bin/catalina.sh stop

#RUN   /root/admintools/openam/bin/ssoadm do-batch -u amadmin -f /root/openam/.passwordfile -Z $file
# 1. Tomcat 10 use karo (Jakarta EE support ke liye jo Tomcat 10+ mein hai)
FROM tomcat:10.1-jdk17-openjdk-slim

# 2. Purani default files hatao
RUN rm -rf /usr/local/tomcat/webapps/*

# 3. Apni WAR file ko ROOT.war ke naam se copy karo
# Dhyan de: Agar tune pom.xml mein finalName change nahi kiya, 
# toh yahan poora bada naam likhna: target/Spring_cart-0.0.1-SNAPSHOT.war
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# 4. Port 8080 expose karo
EXPOSE 8080

# 5. Tomcat start kardo
CMD ["catalina.sh", "run"]
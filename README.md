# Plattform für Verein für soziale Arbeit und Kultur in Siegen
## Konzeptionierung und Entwicklung einer Web-Applikation zur Digitalisierung der Arbeitsprozesse einer sozialen Organisation
### Bachelorarbeit

Das Projekt wurde als Bachelorarbeit an der Universität Siegen etabliert und präsentiert und wurde von [AR Dr.-Ing. Andreas Hoffmann](https://www.bs.informatik.uni-siegen.de/mitarbeiter/hoffmann/index_html)  betreut.

Diese Arbeit befasst sich mit der Konzipierung, Implementierung und dem Design einer Web-Applikation mit dem Ziel, den Arbeitsprozess einer sozialen Organisation zu digitalisieren und damit zu erleichtern und besser zu organisieren.
Hierzu wird das Spring Framework in Verbindung mit HTML, CSS, JavaScript, Datenbank SQlite und verschiedene API verwenden.
Dieses Projekt kann als Vorlage für die meisten sozialen Organisationen verwendet werden, aber im Fokus stand die Erfüllung der Anforderungen der Arbeitsprozesse des Vereins für Soziale Arbeit und Kultur Südwestfalen [VAKS](https://www.vaks.info) in Siegen.



### Built with :
-  Java Spring Boot
    - Das Spring Boot Framework (kurz Spring) ist ein quelloffenes Framework für die Java-Plattform, welches oft für Web-Anwendungen verwendet wird. Ziel des Spring Frameworks ist es, die Entwicklung mit Java/Java EE zu vereinfachen und gute Programmierpraktiken zu fördern. Spring bietet mit einem breiten Spektrum an Funktionalität eine ganzheitliche Lösung zur Entwicklung von Anwendungen und deren Geschäftslogiken; dabei steht die Entkopplung der Applikationskomponenten im Vordergrund.
- Google Calendar API
    - Die Google Kalender-API ist eine RESTful-API, auf die über explizite HTTP-Aufrufe oder über die Google-Clientbibliotheken zugegriffen werden kann. Die API stellt die meisten der in der Google Kalender-Weboberfläche verfügbaren Funktionen bereit.
- Google Dialog Flow
    - Dialogflow ist eine Plattform zum Verstehen natürlicher Sprache, die zum Entwerfen und Integrieren einer dialogorientierten Benutzeroberfläche in mobile Apps, Webanwendungen, Geräte, Bots, interaktive Sprachantwortsysteme und verwandte Anwendungen verwendet wird.
- SQLite
    - SQLite ist eine gemeinfreie Programmbibliothek, die ein relationales Datenbanksystem enthält. SQLite wird in Mobiltelefonen (Android, iOS, Symbian OS, Windows Phone), in Browsern (Firefox, Safari, Chrome), Skype und vielen anderen Anwendungen eingesetzt. Es ist das verbreitetste und meistverwendete Datenbanksystem der Welt. SQLite unterstützt einen Großteil der im SQL-92-Standard festgelegten SQL-Sprachbefehle. Unter anderem implementiert SQLite Transaktionen, Unterabfragen (Subselects), Sichten (Views), Trigger und benutzerdefinierte Funktionen.
- JavaScript
- HTML 5
- CSS

### Anforderungsanalyse :
- Digitalisierung aller Dokumenten
- Hochladen der Dokumente Online
- Elektronischer Kalender
- Online Terminbuchungssystem
- Statistiken des Vereins
- Chatbot


### Database :
Hier ist die SQL-Datei zum Erstellen der Datenbank
``` ruby
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Mother_Language" (
	"language_id"	INTEGER NOT NULL UNIQUE,
	"language"	varchar,
	PRIMARY KEY("language_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "User_Mother_Language" (
	"user_id"	INTEGER,
	"language_id"	INTEGER,
	FOREIGN KEY("user_id") REFERENCES "User"("user_id"),
	FOREIGN KEY("language_id") REFERENCES "Mother_Language"("language_id")
);
CREATE TABLE IF NOT EXISTS "Address" (
	"address_id"	INTEGER NOT NULL UNIQUE,
	"street"	varchar,
	"number"	varchar,
	"city"	varchar,
	"post_code"	INTEGER,
	PRIMARY KEY("address_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "User_Address" (
	"user_id"	INTEGER,
	"address_id"	INTEGER,
	FOREIGN KEY("user_id") REFERENCES "User"("user_id"),
	FOREIGN KEY("address_id") REFERENCES "Address"("address_id")
);
CREATE TABLE IF NOT EXISTS "User_Residence_Permit" (
	"user_id"	INTEGER,
	"residence_permit_id"	INTEGER,
	FOREIGN KEY("residence_permit_id") REFERENCES "Residence_Permit"("residence_permit_id"),
	FOREIGN KEY("user_id") REFERENCES "User"("user_id")
);
CREATE TABLE IF NOT EXISTS "Role" (
	"role_id"	INTEGER,
	"role_type"	varchar,
	PRIMARY KEY("role_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "User_Role" (
	"user_id"	INTEGER,
	"role_id"	INTEGER,
	FOREIGN KEY("user_id") REFERENCES "User"("user_id"),
	FOREIGN KEY("role_id") REFERENCES "Role"("role_id")
);
CREATE TABLE IF NOT EXISTS "User_Education" (
	"user_id"	INTEGER,
	"education_id"	INTEGER,
	FOREIGN KEY("user_id") REFERENCES "User"("user_id"),
	FOREIGN KEY("education_id") REFERENCES "Education"("education_id")
);
CREATE TABLE IF NOT EXISTS "Document_Type" (
	"document_id"	INTEGER,
	"type_id"	INTEGER,
	FOREIGN KEY("type_id") REFERENCES "Type"("type_id"),
	FOREIGN KEY("document_id") REFERENCES "Document"("document_id")
);
CREATE TABLE IF NOT EXISTS "Kunde_Supervised_By_Worker" (
	"kunde_id"	INTEGER,
	"worker_id"	INTEGER,
	FOREIGN KEY("worker_id") REFERENCES "User"("user_id"),
	FOREIGN KEY("kunde_id") REFERENCES "User"("user_id")
);
CREATE TABLE IF NOT EXISTS "Residence_Permit" (
	"residence_permit_id"	INTEGER NOT NULL UNIQUE,
	"residence_permit_type"	varchar,
	PRIMARY KEY("residence_permit_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Education" (
	"education_id"	INTEGER,
	"high_school"	boolean,
	"university"	boolean,
	"integration_course"	boolean,
	"dsh_course"	boolean,
	"german_level"	varchar,
	PRIMARY KEY("education_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "User" (
	"user_id"	INTEGER NOT NULL UNIQUE,
	"first_name"	varchar,
	"last_name"	varchar,
	"birthday"	varchar,
	"gender"	varchar,
	"country"	varchar,
	"email"	varchar UNIQUE,
	"mobile"	varchar,
	"username"	varchar UNIQUE,
	"password"	varchar,
	PRIMARY KEY("user_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "User_Calendar" (
	"user_id"	INTEGER,
	"calendar_id"	INTEGER,
	FOREIGN KEY("calendar_id") REFERENCES "Calendar"("calendar_id"),
	FOREIGN KEY("user_id") REFERENCES "User"("user_id")
);
CREATE TABLE IF NOT EXISTS "Calendar" (
	"calendar_id"	INTEGER,
	"string_calendar_id"	TEXT UNIQUE,
	"calendar_name"	varchar,
	PRIMARY KEY("calendar_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Type" (
	"type_id"	INTEGER,
	"document_type"	varchar,
	PRIMARY KEY("type_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "User_Event" (
	"event_id"	INTEGER,
	"created_by_user_id"	INTEGER,
	"for_user_id"	INTEGER,
	FOREIGN KEY("event_id") REFERENCES "Event"("event_id"),
	FOREIGN KEY("created_by_user_id") REFERENCES "User"("user_id"),
	FOREIGN KEY("for_user_id") REFERENCES "User"("user_id")
);
CREATE TABLE IF NOT EXISTS "Event" (
	"event_id"	INTEGER,
	"string_event_id"	INTEGER,
	"event_name"	varchar,
	"from_date"	varchar,
	"from_time"	varchar,
	"to_date"	varchar,
	"to_time"	varchar,
	"location"	varchar,
	"event_type"	TEXT,
	"calendar_id"	INTEGER,
	PRIMARY KEY("event_id" AUTOINCREMENT),
	FOREIGN KEY("calendar_id") REFERENCES "Calendar"("calendar_id")
);
CREATE TABLE IF NOT EXISTS "User_Document" (
	"document_id"	INTEGER,
	"user_id"	INTEGER,
	"document_for_user"	INTEGER,
	FOREIGN KEY("user_id") REFERENCES "User"("user_id"),
	FOREIGN KEY("document_id") REFERENCES "Document"("document_id")
);
CREATE TABLE IF NOT EXISTS "Document" (
	"document_id"	INTEGER,
	"document_name"	varchar,
	"document_language"	TEXT,
	"document_data"	BLOB,
	"document_version"	varchar,
	"document_upload_date"	varchar,
	"prefix"	TEXT NOT NULL,
	"path"	TEXT,
	PRIMARY KEY("document_id" AUTOINCREMENT)
);
```

### Dependencies :
Hier sind alle notwindige Dependencies
``` ruby
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.4.5</version>
		<relativePath /> <!-- lookup parent from repository -->
	</parent>
	<groupId>VAKS</groupId>
	<artifactId>VAKS</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>VAKS</name>
	<description>Web application for VAKS</description>
	<properties>
		<java.version>11</java.version>
	</properties>


	<dependencies>

		<!-- Don't Delete Those Dependency They are the main to run the application 
			1, 2, 3 -->
		<dependency>	<!-- Dependency 1 -->
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>	<!-- Dependency 2 -->
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>

		<dependency>	<!-- Dependency 3 -->
			<groupId>org.apache.tomcat.embed</groupId>
			<artifactId>tomcat-embed-jasper</artifactId>
			<scope>provided</scope>
		</dependency>
		<!-- Don't Delete Those Dependency They are the main to run the application 
			1, 2, 3 -->


		<!-- Sqlite Dependency -->
		<dependency>
			<groupId>org.xerial</groupId>
			<artifactId>sqlite-jdbc</artifactId>
			<version>3.30.1</version>
		</dependency>
		<!-- Sqlite Dependency -->

		<!-- To Refresh without restart the server -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-devtools</artifactId>
			<optional>true</optional>
		</dependency>
		<!-- To Refresh without restart the server -->


		<!-- Google Calendar API Dependency -->


		<!-- https://mvnrepository.com/artifact/com.google.api-client/google-api-client -->

		<dependency>
			<groupId>com.google.api-client</groupId>
			<artifactId>google-api-client</artifactId>
			<version>1.23.0</version>
		</dependency>


		<!-- https://mvnrepository.com/artifact/com.google.oauth-client/google-oauth-client-jetty -->

		<dependency>
			<groupId>com.google.oauth-client</groupId>
			<artifactId>google-oauth-client-jetty</artifactId>
			<version>1.23.0</version>
		</dependency>


		<!-- https://mvnrepository.com/artifact/com.google.apis/google-api-services-calendar -->

		<dependency>
			<groupId>com.google.apis</groupId>
			<artifactId>google-api-services-calendar</artifactId>
			<version>v3-rev305-1.23.0</version>
		</dependency>

		<!-- Google Calendar API Dependency -->

		<!-- Gmail -->
		<dependency>
			<groupId>javax.mail</groupId>
			<artifactId>mail</artifactId>
			<version>1.4.7</version>
		</dependency>
		<!-- Gmail -->

		<!-- Send SMS -->
		<dependency>
			<groupId>com.twilio.sdk</groupId>
			<artifactId>twilio</artifactId>
			<version>7.20.0</version>
		</dependency>
		<!-- Send SMS -->


	</dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
		</plugins>
	</build>

</project>
```

### Das Projekt ausfühen :
Zuerst wurde die Anwendung auf dem lokalen Computer mit dem Betriebssystem macOS Big Sur und auf einem Macbook Air erstellt. 
Mit dieser einfachen Anwendung wurden viele der Funktionen eingeführt und konfiguriert, die später im größeren Kontext verwendet werden. Zu diesem Zweck wurde das Maven Plugin mit einem eingebetteten Anwendungsserver verwendet.

Die Anwendung wurde mit dem Git-Repository verbunden, das den gesamten Quellcode enthält und die Versionskontrolle für die Anwendung durchführt. 
Die Datenbank wurde so erstellt und konfiguriert, dass sie zuverlässig und skalierbar ist und mit der Anwendung verbunden wurde.
Die Anwendung kann von meinem Github durch das Klonen des Repositorys ```Plattform_VAKS_Siegen``` heruntergeladen werden. 

Durch die Eingabe der folgenden Befehle im Terminal kann der Prozess durchgeführt werden :
Apache Maven muss installiert sein oder kann über den folgenden Befehl durch Homebrew installiert werden:
```brew install maven```

Bei der Eingabe des Befehls ```mvn spring-boot:run``` im selben Verzeichnis, in dem der Klonen-Prozess durchgeführt wurde, dann ist die Anwendung über Port ```8080``` zugänglich.
Die Homepage kann über den Browser über die URI ```localhost:8080/``` aufgerufen werden.

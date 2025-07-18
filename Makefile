MDSL:=./scripts/build-mdsl-entry.sh -v

COUNTRIES:=AT BE BG HR CZ CY DE DK EE FI FR EL HU IS IE IT LI LV LT LU MT NL NO PL PT SK SI ES SE

.PHONY: update $(COUNTRIES) prod.xml test.xml

all: update

docker:
	@docker build -t eidas-cefwiki-mdsl .

update: $(COUNTRIES) prod.xml test.xml certs

prod.xml:
	@./scripts/build-mdsl.sh prod > $@
test.xml:
	@./scripts/build-mdsl.sh test > $@

%.crt: %.xml
	@xsltproc extract-certificates.xsl $< > $@

certs:
	for c in $(COUNTRIES); do $(MAKE) prod/$$c.crt test/$$c.crt; done

EU:
	# European Commission
	$(MDSL) -t EU -c https://ecas.ec.europa.eu/cas/eidas/metadata/ecas-ec-europa-eu.xml > prod/EU.xml
	$(MDSL) -t EU -c https://ecas.acceptance.ec.europa.eu/cas/eidas/metadata/ecas-acceptance-ec-europa-eu.xml > test/EU.xml

AT:
	# Austria
	$(MDSL) -t AT -p https://eidas.bmi.gv.at/EidasNode/ServiceMetadata -c https://eidas.bmi.gv.at/EidasNode/ConnectorMetadata > prod/AT.xml
	$(MDSL) -t AT -p https://eidas-test.bmi.gv.at/EidasNode/ServiceMetadata -c https://eidas-test.bmi.gv.at/EidasNode/ConnectorMetadata > test/AT.xml

BE:
	# Belgium
	$(MDSL) -t BE -p https://idp.iamfas.belgium.be/EidasNode/ServiceMetadata -c https://idp.iamfas.belgium.be/EidasNode/ConnectorMetadata > prod/BE.xml
	$(MDSL) -t BE -p https://idp.iamfas.qa.belgium.be/EidasNode/ServiceMetadata -c https://idp.iamfas.qa.belgium.be/EidasNode/ConnectorMetadata > test/BE.xml

BG:
	# Bulgaria
	#$(MDSL) -t BG -p https://eidas.egov.bg/EidasNode/ServiceMetadata -c https://eidas.egov.bg/EidasNode/ConnectorMetadata > prod/BG.xml
	$(MDSL) -t BG -c https://eidas.egov.bg/EidasNode/ConnectorMetadata > prod/BG.xml
	#$(MDSL) -t BG -p https://eidas-test.egov.bg/EidasNode/ServiceMetadata -c https://eidas-test.egov.bg/EidasNode/ConnectorMetadata > test/BG.xml
	$(MDSL) -t BG -c https://eidas-test.egov.bg/EidasNode/ConnectorMetadata > test/BG.xml


CZ:
	# Czech Republic
	$(MDSL) -t CZ -p https://srv.eidasnode.cz/EidasNode/ServiceMetadata -c https://conn.eidasnode.cz/EidasNode/ConnectorMetadata > prod/CZ.xml
	$(MDSL) -t CZ -p https://srv.dev.eidasnode.cz/EidasNode/ServiceMetadata -c https://conn.dev.eidasnode.cz/EidasNode/ConnectorMetadata > test/CZ.xml

CY:
	# Cyprus
	$(MDSL) -t CY -p https://eidas.mof.gov.cy/EidasNode/ServiceMetadata -c https://eidas.mof.gov.cy/EidasNode/ConnectorMetadata > prod/CY.xml
	$(MDSL) -t CY -p https://pre-eidas.mof.gov.cy/EidasNode/ServiceMetadata -c https://pre-eidas.mof.gov.cy/EidasNode/ConnectorMetadata > test/CY.xml

DE:
	# Germany / Tyskland
	$(MDSL) -t DE -p https://demw.eidas.swedenconnect.se/eidas-middleware/Metadata > prod/DE-demw-se.xml
	$(MDSL) -t DE -p https://qa.demw.eidas.swedenconnect.se/eidas-middleware/Metadata > test/DE.xml
	$(MDSL) -t DE -p https://test.demw.eidas.swedenconnect.se/eidas-middleware/Metadata > test/DE-test.xml

DK:
	# Denmark / Danmark
	$(MDSL) -t DK -p https://eidasservice.eid.digst.dk/Metadata -c https://eidasconnector.eid.digst.dk/Metadata > prod/DK.xml
	$(MDSL) -t DK -p https://eidasservice.test.eid.digst.dk/Metadata -c https://eidasconnector.test.eid.digst.dk/Metadata > test/DK.xml

EE:
	# Estonia
	$(MDSL) -t EE -p https://eidas.ria.ee/EidasNode/ServiceMetadata -c https://eidas.ria.ee/EidasNode/ConnectorMetadata > prod/EE.xml
	$(MDSL) -t EE -p https://eidastest.eesti.ee/EidasNode/ServiceMetadata -c https://eidastest.eesti.ee/EidasNode/ConnectorMetadata > test/EE.xml

ES:
	# Spain
	$(MDSL) -t ES -p https://eidas.redsara.es/EidasNode/ServiceMetadata -c https://eidas.redsara.es/EidasNode/ConnectorMetadata > prod/ES.xml
	$(MDSL) -t ES -p https://se-eidas.redsara.es/EidasNode/ServiceMetadata -c https://se-eidas.redsara.es/EidasNode/ConnectorMetadata > test/ES.xml

FI:
	# Finland
	$(MDSL) -t FI -c https://nodefi1.eidas.tunnistus.fi/EidasNode/ConnectorMetadata > prod/FI.xml
	$(MDSL) -t FI -p https://nodefi1.eidas-qa.tunnistus.fi/EidasNodeProxy/ServiceMetadata -c https://nodefi1.eidas-qa.tunnistus.fi/EidasNode/ConnectorMetadata > test/FI.xml
	$(MDSL) -t FI -c https://nodefi1.apro.tunnistus.fi/EidasNode/ConnectorMetadata > test/FI-dev.xml

FR:
	# France
	#$(MDSL) -t FR -p https://eidas.franceconnect.gouv.fr/EidasNode/ServiceMetadata -c https://eidas.franceconnect.gouv.fr/EidasNode/ConnectorMetadata > prod/FR.xml
	$(MDSL) -t FR -p https://eidas.franceconnect.gouv.fr/EidasNode/ServiceMetadata   -c https://eidas.franceconnect.gouv.fr/EidasNode/ConnectorMetadata > prod/FR.xml
	$(MDSL) -t FR -p https://eidas.pp.dev-franceconnect.fr/EidasNode/ServiceMetadata -c https://eidas.pp.dev-franceconnect.fr/EidasNode/ConnectorMetadata > test/FR.xml

EL:
	# Greece former known as GR
	#$(MDSL) -t EL -p https://eidas.gov.gr/EidasNode/ServiceMetadata -c https://eidas.gov.gr/EidasNode/ConnectorMetadata > prod/EL.xml
	$(MDSL) -t EL -c https://eidas.gov.gr/EidasNode/ConnectorMetadata > prod/EL.xml
	#$(MDSL) -t EL -p https://pre.eidas.gov.gr/EidasNode/ServiceMetadata -c https://pre.eidas.gov.gr/EidasNode/ConnectorMetadata > test/EL.xml
	$(MDSL) -t EL -c https://pre.eidas.gov.gr/EidasNode/ConnectorMetadata > test/EL.xml

HR:
	# Croatia
	$(MDSL) -t HR -p https://eidas.gov.hr/EidasNodeProxy/ServiceMetadata -c https://eidas.gov.hr/EidasNodeConnector/ConnectorMetadata > prod/HR.xml
	$(MDSL) -t HR -p https://eidastst.fina.hr/EidasNodeProxy/ServiceMetadata -c https://eidastst.fina.hr/EidasNodeConnector/ConnectorMetadata > test/HR.xml

HU:
	# Hungary
	#$(MDSL) -t HU -p https://hpeps.teszt.gov.hu/eidas/saml/authnrequest -c https://hpeps.teszt.gov.hu/eidas/saml/metadata.xml > test/HU.xml
	$(MDSL) -t HU -p https://uj-test.eidas.gov.hu/proxy/realms/ProxyRealm/protocol/saml/descriptor -c https://uj-test.eidas.gov.hu/connector/realms/ConnectorRealm/broker/router-saml/endpoint/descriptor > test/HU.xml

IE:
	# Ireland
	#$(MDSL) -t IE -p https://prod.eidasnode.gov.ie/EidasNode/ServiceMetadata -c https://prod.eidasnode.gov.ie/EidasNode/ConnectorMetadata > prod/IE.xml
	$(MDSL) -t IE -c https://prod.eidasnode.gov.ie/EidasNode/ConnectorMetadata > prod/IE.xml
	$(MDSL) -t IE -p https://demo.eidasnode.gov.ie/EidasNode/ServiceMetadata -c https://demo.eidasnode.gov.ie/EidasNode/ConnectorMetadata > test/IE.xml

IS:
	# Iceland
	#$(MDSL) -t IS -p https://node.island.is/eidas-node/ServiceMetadata -c https://node.island.is/eidas-node/ConnectorMetadata > prod/IS.xml
	$(MDSL) -t IS -c https://node.island.is/eidas-node/ConnectorMetadata > prod/IS.xml
	$(MDSL) -t IS -p https://testnode.island.is/eidas-node/ServiceMetadata -c https://testnode.island.is/eidas-node/ConnectorMetadata > test/IS.xml

IT:
	# Italy
	$(MDSL) -t IT -p https://service.eid.gov.it/EidasNode/ServiceMetadata -c https://connector.eid.gov.it/EidasNode/ConnectorMetadata > prod/IT.xml
	$(MDSL) -t IT -p https://service.pre.eid.gov.it/EidasNode/ServiceMetadata -c https://connector.pre.eid.gov.it/EidasNode/ConnectorMetadata > test/IT.xml

LI:
	# Liechtenstein
	$(MDSL) -t LI -p https://node.llv.li/EidasNode/ServiceMetadata -c https://node.llv.li/EidasNode/ConnectorMetadata > prod/LI.xml
	$(MDSL) -t LI -p https://nodea.llv.li/EidasNode/ServiceMetadata -c https://nodea.llv.li/EidasNode/ConnectorMetadata > test/LI.xml

LT:
	# Lithuania
	$(MDSL) -t LT -p https://peps2.eid.lt/EidasNode/ServiceMetadata -c https://peps2.eid.lt/EidasNode/ConnectorMetadata > prod/LT.xml
	$(MDSL) -t LT -p https://testpeps.eid.lt/EidasNode/ServiceMetadata -c https://testpeps.eid.lt/EidasNode/ConnectorMetadata > test/LT.xml

LU:
	# Luxembourg
	$(MDSL) -t LU -p https://eidas.services-publics.lu/cisie-node/ServiceMetadata -c https://eidas.services-publics.lu/cisie-node/ConnectorMetadata > prod/LU.xml
	$(MDSL) -t LU -p https://eidas-test.services-publics.lu/cisie-node/ServiceMetadata -c https://eidas-test.services-publics.lu/cisie-node/ConnectorMetadata > test/LU.xml

LV:
	# Latvia
	$(MDSL) -t LV -p https://eidas.vraa.gov.lv/EidasNode/ServiceMetadata -c https://eidas.vraa.gov.lv/EidasNode/ConnectorMetadata > prod/LV.xml
	$(MDSL) -t LV -p https://eidastest.vraa.gov.lv/EidasNode/ServiceMetadata -c https://eidastest.vraa.gov.lv/EidasNode/ConnectorMetadata> test/LV.xml

MT:
	# Malta
	$(MDSL) -t MT -p https://mteidasnode.gov.mt/EidasNode/ServiceMetadata -c https://mteidasnode.gov.mt/EidasNode/ConnectorMetadata > prod/MT.xml
	$(MDSL) -t MT -p https://stgmteidasnode.gov.mt/EidasNode/ServiceMetadata -c https://stgmteidasnode.gov.mt/EidasNode/ConnectorMetadata > test/MT.xml

NL:
	# Netherlands
	$(MDSL) -t NL -p https://eidas.minez.nl/EidasNodeP/ServiceMetadata -c https://eidas.minez.nl/EidasNodeC/ConnectorMetadata > prod/NL.xml
	$(MDSL) -t NL -p https://acc-eidas.minez.nl/EidasNodeP/ServiceMetadata -c https://acc-eidas.minez.nl/EidasNodeC/ConnectorMetadata > test/NL.xml

NO:
	# Norway / Norge
	#$(MDSL) -t NO -p https://eidas.difi.no/EidasNode/ServiceMetadata -c https://eidas.difi.no/EidasNode/ConnectorMetadata > prod/NO.xml
	$(MDSL) -t NO -c https://connector.eidasnode.no/ConnectorMetadata > prod/NO.xml
	$(MDSL) -t NO -p https://proxy.test.eidasnode.no/ServiceMetadata -c https://connector.test.eidasnode.no/ConnectorMetadata  > test/NO.xml

PL:
	# Poland / Polen
	$(MDSL) -t PL -p https://plnode.eidas.gov.pl/2.6/Node/ServiceMetadata -c https://plnode.eidas.gov.pl/2.6/Node/ConnectorMetadata > prod/PL.xml
	$(MDSL) -t PL -p https://node.test.eidas.gov.pl/2.6/Node/ServiceMetadata -c https://node.test.eidas.gov.pl/2.6/Node/ConnectorMetadata > test/PL.xml

PT:
	# Portugal
	$(MDSL) -t PT -p https://eidas.autenticacao.gov.pt/EidasNode/ServiceMetadata -c https://eidas.autenticacao.gov.pt/EidasNode/ConnectorMetadata > prod/PT.xml
	$(MDSL) -t PT -p https://ppreidas.autenticacao.gov.pt/EidasNode/ServiceMetadata -c https://ppreidas.autenticacao.gov.pt/EidasNode/ConnectorMetadata > test/PT.xml

RO:
	# Romania
	# $(MDSL) -t RO -p https://eidas.autenticacao.gov.pt/EidasNode/ServiceMetadata -c  https://eidas.gov.ro/EidasNode/ConnectorMetadata> prod/RO.xml
	# $(MDSL) -t RO -p https://dev.eidas.gov.ro/EidasNode/ServiceMetadata -c https://dev.eidas.gov.ro/EidasNode/ConnectorMetadata > test/RO.xml
	$(MDSL) -t RO -c https://eidas.gov.ro/EidasNode/ConnectorMetadata > prod/RO.xml
	$(MDSL) -t RO -c https://dev.eidas.gov.ro/EidasNode/ConnectorMetadata > test/RO.xml

SK:
	# Slovakia
	$(MDSL) -t SK -p https://eidas.slovensko.sk/EidasNode/ServiceMetadata -c https://eidas.slovensko.sk/EidasNode/ConnectorMetadata > prod/SK.xml
	$(MDSL) -t SK -p https://eidas.upvsfixnew.gov.sk/EidasNode/ServiceMetadata -c https://eidas.upvsfixnew.gov.sk/EidasNode/ConnectorMetadata > test/SK.xml

SI:
	# Slovenia
	$(MDSL) -t SI -p https://sipeps.gov.si/EidasNode/ServiceMetadata -c https://sipeps.gov.si/EidasNode/ConnectorMetadata > prod/SI.xml
	$(MDSL) -t SI -p https://sipeps-test.setcce.si/EidasNode/ServiceMetadata -c https://sipeps-test.setcce.si/EidasNode/ConnectorMetadata > test/SI.xml

SE:
	#SE Sweden / Sverige
	$(MDSL) -t SE -p https://proxy.eidas.swedenconnect.se/eidas-ps/ServiceMetadata -c https://connector.eidas.swedenconnect.se/idp/metadata/sp > prod/SE.xml
	$(MDSL) -t SE -p https://qa.proxy.eidas.swedenconnect.se/eidas-ps/ServiceMetadata -c https://qa.connector.eidas.swedenconnect.se/idp/metadata/sp > test/SE.xml
	$(MDSL) -t SE -p https://test.proxy.eidas.swedenconnect.se/eidas-ps/ServiceMetadata -c https://test.connector.eidas.swedenconnect.se/idp/metadata/sp > test/SE-test.xml

XA:
	$(MDSL) -t XA -c https://xa.testnode.eidastest.se/EidasNodeConnector/ConnectorMetadata -p https://xa.testnode.eidastest.se/EidasNodeProxy/ServiceMetadata > test/XA.xml

XB:
	$(MDSL) -t XB -c https://xb.testnode.eidastest.se/EidasNodeConnector/ConnectorMetadata -p https://xb.testnode.eidastest.se/EidasNodeProxy/ServiceMetadata > test/XB.xml

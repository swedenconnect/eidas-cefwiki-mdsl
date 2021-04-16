MDSL:=./scripts/build-mdsl-entry.sh -v

COUNTRIES:=AT BE BG HR CZ CY DK EE FI FR GR HU IS IE IT LV LT LU MT NL NO PL PT SK SI ES SE GB

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

AT:
	$(MDSL) -t AT -c https://eidas.bmi.gv.at/EidasNode/ConnectorMetadata > prod/AT.xml
	$(MDSL) -t AT -c https://eidas-test.bmi.gv.at/EidasNode/ConnectorMetadata > test/AT.xml

BE:
	$(MDSL) -t BE -p https://idp.iamfas.belgium.be/EidasNode/ServiceMetadata -c https://idp.iamfas.belgium.be/EidasNode/ConnectorMetadata > prod/BE.xml
	$(MDSL) -t BE -p https://idp.iamfas.qa.belgium.be/EidasNode/ServiceMetadata -c https://idp.iamfas.qa.belgium.be/EidasNode/ConnectorMetadata > test/BE.xml

BG:
	$(MDSL) -t BG -c https://eidas.egov.bg/EidasNode/ConnectorMetadata > prod/BG.xml
	$(MDSL) -t BG -c https://eidas-test.egov.bg/EidasNode/ConnectorMetadata > test/BG.xml


HR:
	$(MDSL) -t HR -p https://eidas.gov.hr/EidasNode/ServiceMetadata -c https://eidas.gov.hr/EidasNode/ConnectorMetadata > prod/HR.xml
	$(MDSL) -t HR -p https://eidastst.fina.hr/EidasNode/ServiceMetadata -c https://eidastst.fina.hr/EidasNode/ConnectorMetadata > test/HR.xml

CZ:
	$(MDSL) -t CZ -p https://srv.dev.eidasnode.cz/EidasNode/ServiceMetadata -c https://conn.dev.eidasnode.cz/EidasNode/ConnectorMetadata > test/CZ.xml
	$(MDSL) -t CZ -p https://srv.eidasnode.cz/EidasNode/ServiceMetadata -c https://conn.eidasnode.cz/EidasNode/ConnectorMetadata > prod/CZ.xml

CY:
	$(MDSL) -t CY -p https://pre-eidas.mof.gov.cy/EidasNode/ServiceMetadata -c https://pre-eidas.mof.gov.cy/EidasNode/ConnectorMetadata > test/CY.xml

DK:
	$(MDSL) -t DK -c https://eidasconnector.eid.digst.dk/Metadata > prod/DK.xml
	$(MDSL) -t DK -p https://eidasservice.test.eid.digst.dk/Metadata -c https://eidasconnector.test.eid.digst.dk/Metadata > test/DK.xml

EE:
	$(MDSL) -t EE -p https://eidas.ria.ee/EidasNode/ServiceMetadata -c https://eidas.ria.ee/EidasNode/ConnectorMetadata > prod/EE.xml
	$(MDSL) -t EE -p https://eidastest.eesti.ee/EidasNode/ServiceMetadata -c https://eidastest.eesti.ee/EidasNode/ConnectorMetadata > test/EE.xml

FI:
	$(MDSL) -t FI -c https://nodefi1.eidas.tunnistus.fi/EidasNode/ConnectorMetadata > prod/FI.xml
	$(MDSL) -t FI -c https://nodefi1.apro.tunnistus.fi/EidasNode/ConnectorMetadata > test/FI.xml #-c https://nodefi1.eidas-qa.tunnistus.fi/EidasNode/ConnectorMetadata > test/FI.xml

FR:
	$(MDSL) -t FR -p https://eidas.pp.dev-franceconnect.fr/EidasNode/ServiceMetadata -c https://eidas.pp.dev-franceconnect.fr/EidasNode/ConnectorMetadata > test/FR.xml

GR:
	$(MDSL) -t GR -p https://eidas.gov.gr/EidasNode/ServiceMetadata -c https://eidas.gov.gr/EidasNode/ConnectorMetadata > prod/GR.xml
	$(MDSL) -t GR -p https://pre.eidas.gov.gr/EidasNode/ServiceMetadata -c https://pre.eidas.gov.gr/EidasNode/ConnectorMetadata > test/GR.xml

HU:
	$(MDSL) -t HU -p https://hpeps.teszt.gov.hu/eidas/saml/authnrequest -c https://hpeps.teszt.gov.hu/eidas/saml/metadata.xml > test/HU.xml

IS:
	$(MDSL) -t IS -p https://node.island.is/eidas-node/ServiceMetadata -c https://node.island.is/eidas-node/ConnectorMetadata > prod/IS.xml
	$(MDSL) -t IS -p https://testnode.island.is/eidas-node/ServiceMetadata -c https://testnode.island.is/eidas-node/ConnectorMetadata > test/IS.xml

IE:
	$(MDSL) -t IE -p https://demo.eidasnode.gov.ie/EidasNode/ServiceMetadata -c https://demo.eidasnode.gov.ie/EidasNode/ConnectorMetadata > test/IE.xml


IT:
	$(MDSL) -t IT -p https://service.eid.gov.it/EidasNode/ServiceMetadata -c https://connector.eid.gov.it/EidasNode/ConnectorMetadata > prod/IT.xml
	$(MDSL) -t IT -p https://service.pre.eid.gov.it/EidasNode/ServiceMetadata -c https://connector.pre.eid.gov.it/EidasNode/ConnectorMetadata > test/IT.xml

LV:
	$(MDSL) -t LV -p https://eidas.vraa.gov.lv/EidasNode/ServiceMetadata > prod/LV.xml
	$(MDSL) -t LV -p https://eidastest.vraa.gov.lv/EidasNode/ServiceMetadata > test/LV.xml

LT:
	$(MDSL) -t LT -p https://peps2.eid.lt/EidasNode/ServiceMetadata -c https://peps2.eid.lt/EidasNode/ConnectorMetadata > prod/LT.xml
	$(MDSL) -t LT -p https://testpeps.eid.lt/EidasNode/ServiceMetadata -c https://testpeps.eid.lt/EidasNode/ConnectorMetadata > test/LT.xml

LU:
	$(MDSL) -t LU -p https://eidas.services-publics.lu/cisie-node/ServiceMetadata -c https://eidas.services-publics.lu/cisie-node/ConnectorMetadata > prod/LU.xml
	$(MDSL) -t LU -p https://eidas-test.services-publics.lu/cisie-node/ServiceMetadata -c https://eidas-test.services-publics.lu/cisie-node/ConnectorMetadata > test/LU.xml

MT:
	$(MDSL) -t MT -p https://mteidasnode.gov.mt/EidasNode/ConnectorMetadata -c https://mteidasnode.gov.mt/EidasNode/ServiceMetadata > prod/MT.xml
	$(MDSL) -t MT -p https://stgmteidasnode.gov.mt/EidasNode/ServiceMetadata -c https://stgmteidasnode.gov.mt/EidasNode/ConnectorMetadata > test/MT.xml

NL:
	$(MDSL) -t NL -c https://eidas.minez.nl/EidasNodeC/ConnectorMetadata > prod/NL.xml
	$(MDSL) -t NL -p https://acc-eidas.minez.nl/EidasNodeP/ServiceMetadata -c https://acc-eidas.minez.nl/EidasNodeC/ConnectorMetadata > test/NL.xml

NO:
	$(MDSL) -t NO -p https://eidas.difi.no/EidasNode/ServiceMetadata > prod/NO.xml
	$(MDSL) -t NO -p https://eidas-test1.difi.eon.no/EidasNode/ServiceMetadata -c https://eidas-test1.difi.eon.no/EidasNode/ConnectorMetadata  > test/NO.xml

PL:
	$(MDSL) -t PL -p https://plnode.eidas.gov.pl/EidasNode/ServiceMetadata -c https://plnode.eidas.gov.pl/EidasNode/ConnectorMetadata > prod/PL.xml
	$(MDSL) -t PL -p https://test.eidas.gov.pl/EidasNode/ServiceMetadata -c https://test.eidas.gov.pl/EidasNode/ConnectorMetadata > test/PL.xml

PT:
	$(MDSL) -t PT -p https://eidas.autenticacao.gov.pt/EidasNode/ServiceMetadata -c https://eidas.autenticacao.gov.pt/EidasNode/ConnectorMetadata > prod/PT.xml
	$(MDSL) -t PT -p https://preprod.eidas.autenticacao.gov.pt/EidasNode/ServiceMetadata -c  https://preprod.eidas.autenticacao.gov.pt/EidasNode/ConnectorMetadata > test/PT.xml

SK:
	$(MDSL) -t SK -p https://eidas.slovensko.sk/EidasNode/ServiceMetadata -c https://eidas.slovensko.sk/EidasNode/ConnectorMetadata > prod/SK.xml
	$(MDSL) -t SK -p https://eidas.upvsfixnew.gov.sk/EidasNode/ServiceMetadata -c https://eidas.upvsfixnew.gov.sk/EidasNode/ConnectorMetadata > test/SK.xml
       
SI: 
	$(MDSL) -t SI -p https://sipeps.gov.si/EidasNode/ServiceMetadata -c https://sipeps.gov.si/EidasNode/ConnectorMetadata > prod/SI.xml
	$(MDSL) -t SI -p https://sipeps-test.gov.si/EidasNode/ServiceMetadata -c https://sipeps-test.gov.si/EidasNode/ConnectorMetadata > test/SI.xml

ES:
	$(MDSL) -t ES -p https://eidas.redsara.es/EidasNode/ServiceMetadata -c https://eidas.redsara.es/EidasNode/ConnectorMetadata > prod/ES.xml
	$(MDSL) -t ES -p https://se-eidas.redsara.es/EidasNode/ServiceMetadata -c https://se-eidas.redsara.es/EidasNode/ConnectorMetadata > test/ES.xml

SE:
	$(MDSL) -t SE -p https://proxy.eidas.swedenconnect.se/eidas-ps/ServiceMetadata -c https://connector.eidas.swedenconnect.se/idp/metadata/sp > prod/SE.xml
	$(MDSL) -t SE -p https://qa.proxy.eidas.swedenconnect.se/eidas-ps/ServiceMetadata -c https://qa.connector.eidas.swedenconnect.se/idp/metadata/sp > test/SE.xml

GB:
	$(MDSL) -t GB -c https://www.signin.service.gov.uk/SAML2/metadata/connector -p https://proxy-node.eidas.signin.service.gov.uk/ServiceMetadata > prod/GB.xml
	$(MDSL) -t GB -c https://www.integration.signin.service.gov.uk/SAML2/metadata/connector -p https://proxy-node.integration.eidas.signin.service.gov.uk/ServiceMetadata > test/GB.xml

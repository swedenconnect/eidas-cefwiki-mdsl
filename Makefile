MDSL:=./scripts/build-mdsl-entry.sh

update: p np

p:
	$(MDSL) -t AT -c https://eidas.bmi.gv.at/EidasNode/ConnectorMetadata -o production/AT.xml
	$(MDSL) -t BE -p https://idp.iamfas.belgium.be/EidasNode/ServiceMetadata -c https://idp.iamfas.belgium.be/EidasNode/ConnectorMetadata -o production/BE.xml
	$(MDSL) -t HR -p https://eidastst.fina.hr/EidasNode/ServiceMetadata -c https://eidastst.fina.hr/EidasNode/ConnectorMetadata -o production/HR.xml
	$(MDSL) -t EE -p https://eidas.ria.ee/EidasNode/ServiceMetadata -c https://eidas.ria.ee/EidasNode/ConnectorMetadata -o production/EE.xml
	$(MDSL) -t GR -p https://eidas.gov.gr/EidasNode/ServiceMetadata -c https://eidas.gov.gr/EidasNode/ConnectorMetadata -o production/GR.xml
	$(MDSL) -t IS -p https://node.island.is/eidas-node/ServiceMetadata -c https://node.island.is/eidas-node/ConnectorMetadata -o production/IS.xml
	$(MDSL) -t IT -p https://service.eid.gov.it/EidasNode/ServiceMetadata -c https://connector.eid.gov.it/EidasNode/ConnectorMetadata -o production/IT.xml
# TODO: ttps://com-connector.eid.gov.it/EidasNode/ConnectorMetadata
	$(MDSL) -t LV -p https://eidas.vraa.gov.lv/EidasNode/ServiceMetadata -o production/LV.xml
	$(MDSL) -t LT -p https://peps2.eid.lt/EidasNode/ServiceMetadata -c https://peps2.eid.lt/EidasNode/ConnectorMetadata -o production/LT.xml
	$(MDSL) -t NL -c https://eidas.minez.nl/EidasNodeC/ConnectorMetadata -o production/NL.xml
	$(MDSL) -t NO -p https://eidas.difi.no/EidasNode/ServiceMetadata -o production/NO.xml
	$(MDSL) -t PL -p https://plnode.eidas.gov.pl/EidasNode/ServiceMetadata -c https://plnode.eidas.gov.pl/EidasNode/ConnectorMetadata -o production/PL.xml
	$(MDSL) -t SK -p https://eidas.slovensko.sk/EidasNode/ServiceMetadata -c https://eidas.slovensko.sk/EidasNode/ConnectorMetadata -o production/SK.xml
	$(MDSL) -t SI -p https://sipeps.gov.si/EidasNode/ServiceMetadata -c https://sipeps.gov.si/EidasNode/ConnectorMetadata -o production/SI.xml
	$(MDSL) -t ES -p https://eidas.redsara.es/EidasNode/ServiceMetadata -c https://eidas.redsara.es/EidasNode/ConnectorMetadata -o production/ES.xml
	$(MDSL) -t LU -p https://eidas.services-publics.lu/cisie-node/ServiceMetadata -c https://eidas.services-publics.lu/cisie-node/ConnectorMetadata -o production/LU.xml


np:
	$(MDSL) -t AT -c https://eidas-test.bmi.gv.at/EidasNode/ConnectorMetadata -o nonproduction/AT.xml
	$(MDSL) -t BE -p https://idp.iamfas.qa.belgium.be/EidasNode/ServiceMetadata -c https://idp.iamfas.qa.belgium.be/EidasNode/ConnectorMetadata -o nonproduction/BE.xml
	$(MDSL) -t HR -p https://eidastst.fina.hr/EidasNode/ServiceMetadata -c https://eidastst.fina.hr/EidasNode/ConnectorMetadata -o nonproduction/HR.xml
	$(MDSL) -t CY -p https://pre-eidas.mof.gov.cy/EidasNode/ServiceMetadata -c https://pre-eidas.mof.gov.cy/EidasNode/ConnectorMetadata -o nonproduction/CY.xml
	$(MDSL) -t CZ -p https://srv.dev.eidasnode.cz/EidasNode/ServiceMetadata -c https://conn.dev.eidasnode.cz/EidasNode/ConnectorMetadata -o nonproduction/CZ.xml
	$(MDSL) -t DK -p https://eidasservice.test.eid.digst.dk/metadata -c https://eidasconnector.test.eid.digst.dk/idp -o nonproduction/DK.xml
	$(MDSL) -t EE -p https://eidastest.eesti.ee/EidasNode/ServiceMetadata -c https://eidastest.eesti.ee/EidasNode/ConnectorMetadata -o nonproduction/EE.xml
	$(MDSL) -t FI -c https://nodefi1.apro.tunnistus.fi/EidasNode/ConnectorMetadata -o nonproduction/FI-1.xml
	$(MDSL) -t FI -c https://nodefi1.eidas-qa.tunnistus.fi/EidasNode/ConnectorMetadata -o nonproduction/FI-2.xml
	$(MDSL) -t FR -p http://fc-node.eidas.integ01.dev-franceconnect.fr/FC-eIDAS-Node/ServiceMetadata -o nonproduction/FR.xml
	$(MDSL) -t GR -p https://pre.eidas.gov.gr/EidasNode/ServiceMetadata -c https://pre.eidas.gov.gr/EidasNode/ConnectorMetadata -o nonproduction/GR.xml
	$(MDSL) -t IS -p https://testnode.island.is/eidas-node/ServiceMetadata -c https://testnode.island.is/eidas-node/ConnectorMetadata -o nonproduction/IS.xml
	$(MDSL) -t IT -p https://service.pre.eid.gov.it/EidasNode/ServiceMetadata -c https://connector.pre.eid.gov.it/EidasNode/ConnectorMetadata -o nonproduction/IT.xml
# TODO: https://com-connector.pre.eid.gov.it/EidasNode/ConnectorMetadata
	$(MDSL) -t LV -p https://eidastest.vraa.gov.lv/EidasNode/ServiceMetadata -o nonproduction/LV.xml
	$(MDSL) -t LT -p https://testpeps.eid.lt/EidasNode/ServiceMetadata -c https://testpeps.eid.lt/EidasNode/ConnectorMetadata -o nonproduction/LT.xml
	$(MDSL) -t LU -p https://eidas-test.services-publics.lu/cisie-node/ServiceMetadata -c https://eidas-test.services-publics.lu/cisie-node/ConnectorMetadata -o nonproduction/LU.xml
	$(MDSL) -t MT -p https://stgmteidasnode.gov.mt/EidasNode/ServiceMetadata -c https://stgmteidasnode.gov.mt/EidasNode/ConnectorMetadata -o nonproduction/MT.xml
	$(MDSL) -t NL -p https://acc-eidas.minez.nl/EidasNodeP/ServiceMetadata -c https://acc-eidas.minez.nl/EidasNodeC/ConnectorMetadata -o nonproduction/NL.xml
	$(MDSL) -t NO -p https://eidas-test1.difi.eon.no/EidasNode/ServiceMetadata -c https://eidas-test1.difi.eon.no/EidasNode/ConnectorMetadata  -o nonproduction/NO.xml
	$(MDSL) -t PL -p https://test.eidas.gov.pl/EidasNode/ServiceMetadata -c https://test.eidas.gov.pl/EidasNode/ConnectorMetadata -o nonproduction/PL.xml
	$(MDSL) -t PT -p https://preprod.eidas.autenticacao.gov.pt/EidasNode/ServiceMetadata -c  https://preprod.eidas.autenticacao.gov.pt/EidasNode/ConnectorMetadata -o nonproduction/PT.xml
	$(MDSL) -t SK -p http://eidas.ana.sk/EidasNode/ServiceMetadata -c http://eidas.ana.sk/EidasNode/ConnectorMetadata -o nonproduction/SK-1.xml
	$(MDSL) -t SK -p https://eidas.upvsfixnew.gov.sk/EidasNode/ServiceMetadata -c https://eidas.upvsfixnew.gov.sk/EidasNode/ConnectorMetadata -o nonproduction/SK-2.xml
	$(MDSL) -t SI -p https://sipeps-test.gov.si/EidasNode/ServiceMetadata -c https://sipeps-test.gov.si/EidasNode/ConnectorMetadata -o nonproduction/SI.xml
	$(MDSL) -t ES -p https://se-eidas.redsara.es/EidasNode/ServiceMetadata -c https://se-eidas.redsara.es/EidasNode/ConnectorMetadata -o nonproduction/ES.xml
	$(MDSL) -t UK -c https://www.integration.signin.service.gov.uk/SAML2/metadata/connector -o nonproduction/UK.xml	

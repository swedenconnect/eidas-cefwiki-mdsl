#!/bin/bash

dir=$1

(cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<ser:MetadataServiceList Version="1.0" IssueDate="1970-01-01T00:00:00Z"
   xmlns:xi="http://www.w3.org/2001/XInclude"
   xmlns:ser="http://eidas.europa.eu/metadata/servicelist">
   <ser:SchemeInformation>
      <ser:IssuerName>https://github.com:swedenconnect/eidas-cefwiki-mdsl</ser:IssuerName>
      <ser:SchemeIdentifier>urn:se:elegnamnden:eidas:mdlist:local</ser:SchemeIdentifier>
      <ser:SchemeTerritory>INT</ser:SchemeTerritory>
   </ser:SchemeInformation>
EOF

for fn in $dir/*.xml; do
echo "   <xi:include href='$fn'/>"
done

cat<<EOF
   <ser:DistributionPoints>
      <ser:DistributionPoint>https://raw.githubusercontent.com/swedenconnect/eidas-cefwiki-mdsl/master/$dir.xml</ser:DistributionPoint>
   </ser:DistributionPoints>
</ser:MetadataServiceList>
EOF
) | xmllint --format --xinclude --nsclean --schema schema/MDServiceList_final.xsd -

# Deploying Qualys Virtual Scanner Appliance in Azure using Terraform
[![Terraform](https://img.shields.io/badge/terraform-v1.3+-blue.svg)](https://www.terraform.io/downloads.html)

This code creates:

- Define the Azure Provider
- Create a Resource Group
- Create a VNET
- Create a Subnet
- Create an NSG (Network Security Group) and attach it to the subnet 
- Create a NIC (Network Card) in the Subnet
- Create the Virtual Machine

## How to Get the Latest Qualys Image version

Open Azure Cloud Shell and type:

```
$location = "North Europe"
$publisher = "qualysguard"
$offer = "qualys-virtual-scanner"
Get-AzVMImageSku -Location $location -PublisherName $publisher -Offer $offer | Select Skus

$sku = "qvsa"
Get-AzVMImage -Location $location -PublisherName $publisher -Offer $offer -Skus $sku
$Version": "2.7.3102"
```

## Accepting Marketplace Terms

Get the URN of the MarketPlace license:

```
az vm image list --all --publisher 'qualysguard' --offer 'qualys-virtual-scanner' --sku 'qvsa' --query '[0].urn' 

"qualysguard:qualys-virtual-scanner:qvsa:2.7.2906"
```

then accept the terms of the license:

```
az vm image terms accept --urn 'qualysguard:qualys-virtual-scanner:qvsa:2.7.2906'

{
  "accepted": true,
  "id": "/subscriptions/xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/providers/Microsoft.MarketplaceOrdering/offerTypes/Microsoft.MarketplaceOrdering/offertypes/publishers/qualysguard/offers/qualys-virtual-scanner/plans/qvsa/agreements/current",
  "licenseTextLink": "https://mpcprodsa.blob.core.windows.net/legalterms/3E5ED_legalterms_QUALYSGUARD%253a24QUALYS%253a2DVIRTUAL%253a2DSCANNER%253a24QVSA%253a247X6MWRP2X774O53E7DCCZFOLE2LAAOS6V3PWH3SELAOUCBDJJELHBXCU4VK55ZVSCBRCMWFBIL4DCLAHSWNHXFG2ASI5CJ2Y4WGCPYA.txt",
  "marketplaceTermsLink": "https://mpcprodsa.blob.core.windows.net/marketplaceterms/3EDEF_marketplaceterms_VIRTUALMACHINE%253a24AAK2OAIZEAWW5H4MSP5KSTVB6NDKKRTUBAU23BRFTWN4YC2MQLJUB5ZEYUOUJBVF3YK34CIVPZL2HWYASPGDUY5O2FWEGRBYOXWZE5Y.txt",
  "name": "qvsa",
  "plan": "qvsa",
  "privacyPolicyLink": "https://www.qualys.com/company/privacy/",
  "product": "qualys-virtual-scanner",
  "publisher": "qualysguard",
  "retrieveDatetime": "2022-12-13T14:19:52.7743145Z",
  "signature": "BXHQF4CETVENIRJLNXS6PSH55OQ56YBJNUERE3JQUHQL62BCLE66HCFL6ZRVG7C4ZJK26LD255T666R7NHMWT2SG5GOXIIP6FNOBEFQ",
  "systemData": {
    "createdAt": "2022-12-13T14:19:54.201992+00:00",
    "createdBy": "67580d64-fcf3-4e72-800a-51c45782b701",
    "createdByType": "ManagedIdentity",
    "lastModifiedAt": "2022-12-13T14:19:54.201992+00:00",
    "lastModifiedBy": "67580d64-fcf3-4e72-800a-51c45782b701",
    "lastModifiedByType": "ManagedIdentity"
  },
  "type": "Microsoft.MarketplaceOrdering/offertypes"
}
```

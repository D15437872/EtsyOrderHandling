# EtsyOrderHandling
Automated processing of a sellers Etsy orders on a local machine. It includes a bulk export and a syncronisation of the internal uuid via REST.

**It contains the following functions:**
- Opens a Windows window to choose the date
- Calls the ETSY REST API to export all purchase order data of the choosen day including the shipment address
- Calls the ETSY REST API to save the internal uuid into the internal comment of each order

**Minimum requirements:**
- Windows 10
- Powershell 5.1
- Approved ETSY API App

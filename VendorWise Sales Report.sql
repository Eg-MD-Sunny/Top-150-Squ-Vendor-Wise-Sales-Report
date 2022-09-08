 select Datepart(Month,(dbo.toBdt(Shipment.ReconciledOn)))[Month],
        Datename(Month,(dbo.toBdt(Shipment.ReconciledOn)))[Month],
        ProductVariant.id [PVID],
        ProductVariant.name [Product],
        (COUNT(ThingRequest.ProductVariantId)) [QTY] 
 
 from ThingRequest     
 join Shipment on ThingRequest.ShipmentId=Shipment.Id    
 join ProductVariant on ThingRequest.ProductVariantId=ProductVariant.Id  
 
 where Shipment.ReconciledOn is not null     
 and Shipment.ReconciledOn >= '2022-06-01 00:00 +06:00'     
 and Shipment.ReconciledOn < '2022-09-01 00:00 +06:00'     
 and ShipmentStatus not in (1,9,10)     
 and IsReturned=0     
 and IsCancelled=0     
 and HasFailedBeforeDispatch=0     
 and IsMissingAfterDispatch=0 
 and Shipment.WarehouseId in (25)
 and ProductVariant.name not like '%Gift from chaldal%'
 and ThingRequest.SalePrice > 0
 and ProductVariant.Id in (15871,9917,30567,7601,31262,7609,2476,2168,30411,2121,2443,7454,2157,3369,6263,3543,7276,2493,2514,2519,11901,6940,6138,6931,24521,24265,2145,30953,15577,10164,24267,2315,10520,8846,29883,14530,2141,15974,27704,24798,23086,23085,34367,28825,2352,4171,9024,6672,7277,27861,6942,4272,15119,23424,6092,22286,16182,20361,6250,3117,30214,23855,4022,3159,34329,30936,24266,13562,21359,3725,2243,2257,13554,14146,2259,15618,19972,23430,10168,18695,5823,23584,31256,15598,2120,5637,2179,6200,4001,2184,14636,20655,24278,22583,21031,34370,27865,35649,34364,2423,3673,34777,15498,6373,14634,9549,22500,9445,11862,34733,24860,11960,31207,11973,2258,4388,4373,5758,2207,10939,30710,8951,4476,15579,35562,34332,2384,2326,22625,3682,11967,6267,34210,17043,6933,7666,3374,7757,16206,2180,27860,4375,14827,6205,13605,27171,35635,15581,22503,12978)
 
 group by Datepart(Month,(dbo.toBdt(Shipment.ReconciledOn))),
          Datename(Month,(dbo.toBdt(Shipment.ReconciledOn))),
        ProductVariant.id ,
        ProductVariant.name 
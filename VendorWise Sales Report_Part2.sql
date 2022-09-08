--1st Part
--=========================================
Select a.pvid,
       v.id,
	   v.name

From PurchaseOrder po
join vendor v on v.id=po.vendorid 
Join (   
		Select t.ProductVariantId pvid, max(po.id) poid
	    from thing t 
		join PurchaseOrder po on po.id=t.PurchaseOrderId
		join vendor v on v.id=po.vendorid 

		where v.id not in (468,362,103)

		group by t.ProductVariantId
) a on a.poid=po.id


--2nd Part
--=========================================
Select top 150 pv.id [PVID],
	           pv.name [Product],
	           Count(*) [Sale Quantity]

from ProductVariant pv
join ThingRequest tr on tr.ProductVariantId=pv.id
join Shipment s on s.id=tr.ShipmentId

where s.ReconciledOn is not null
and s.ReconciledOn >= '2022-06-01 00:00 +06:00'
and s.ReconciledOn < '2022-09-01 00:00 +06:00'
and pv.ShelfType not in (5,9)
and s.ShipmentStatus not in (1,9,10)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 1
and pv.name not like '%Gift from chaldal%'
and tr.SalePrice > 0
and s.WarehouseId = 25

group by pv.id,
		 pv.name

order by 3 desc
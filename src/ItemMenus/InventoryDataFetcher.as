﻿import skyui.components.list.BasicList;


class InventoryDataFetcher extends ItemcardDataFetcher
{	
  /* CONSTRUCTORS */
  
	public function InventoryDataFetcher(a_list: BasicList)
	{
		super(a_list);
	}


  /* PUBLIC FUNCTIONS */
	
  	// @override ItemcardDataFetcher
	public function processEntry(a_entryObject: Object, a_itemInfo: Object): Void
	{
		switch (a_itemInfo.type) {
			case InventoryDefines.ICT_ARMOR :
				a_entryObject.infoArmor = a_itemInfo.armor ? a_itemInfo.armor : "-";
				a_entryObject.infoDamage = "-";
				a_entryObject.infoIsEnchanted = (a_itemInfo.effects != "");
				break;
				
			case InventoryDefines.ICT_WEAPON :
				a_entryObject.infoDamage = a_itemInfo.damage ? a_itemInfo.damage : "-";
				a_entryObject.infoArmor = "-";
				a_entryObject.infoIsEnchanted = (a_itemInfo.effects != "");
				break;
				
			case InventoryDefines.ICT_POTION :
				// if potion item has spellCost then it is a scroll
				if (a_itemInfo.skillName)
					a_itemInfo.type = InventoryDefines.ICT_BOOK;
				else if (a_itemInfo.spellCost)
					a_itemInfo.type = InventoryDefines.ICT_SPELL;
				// Fall through
				
			default:
				a_entryObject.infoArmor = "-";
				a_entryObject.infoDamage = "-";
				a_entryObject.infoIsEnchanted = false;
		}

		a_entryObject.infoValue = Math.round(a_itemInfo.value);
		a_entryObject.infoWeight = Math.round(a_itemInfo.weight * 10) / 10;
		a_entryObject.infoType = a_itemInfo.type;
		a_entryObject.infoPotionType = a_itemInfo.potionType;		
		a_entryObject.infoWeightValue = a_itemInfo.weight > 0 ? Math.round(a_itemInfo.value / a_itemInfo.weight) : "-";
		
		a_entryObject.infoIsPoisoned = (a_itemInfo.poisoned > 0);
		a_entryObject.infoIsStolen = (a_itemInfo.stolen > 0);
		a_entryObject.infoIsEquipped = (a_entryObject.equipState > 0);
	}
}
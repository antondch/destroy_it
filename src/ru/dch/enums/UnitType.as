/**
 * User: schegolkov
 * Date: 28.01.14
 * Time: 14:06
 * Email: schegolkov@src-multimedia.ru
 */
package ru.dch.enums
{
import com.dch.enums.UintEnumeration;

public class UnitType extends UintEnumeration
{
    public static const HERO:UnitType = 		new UnitType(1);
    public static const WARRIOR:UnitType = 		new UnitType(2);
    public static const MAGE:UnitType = 		new UnitType(3);

    public static const ENEMY:UnitType = 		new UnitType(4);



    public function UnitType(val:uint)
    {
        super(val);
    }
}

}

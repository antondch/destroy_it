/**
 * User: schegolkov
 * Date: 28.01.14
 * Time: 14:09
 * Email: schegolkov@src-multimedia.ru
 */
package ru.dch.enums
{
import com.dch.enums.StringEnumeration;

public class UnitUpgradeType extends StringEnumeration
{
    public static const U1:UnitUpgradeType = new UnitUpgradeType("U1");
    public static const U2:UnitUpgradeType = new UnitUpgradeType("U2");
    public static const U3:UnitUpgradeType = new UnitUpgradeType("U3");
    public static const U4:UnitUpgradeType = new UnitUpgradeType("U3");

    public function UnitUpgradeType(val:String)
    {
        super(val);
    }
}}

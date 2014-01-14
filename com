package com.kunyihua.crafte;

import com.kunyihua.crafte.config.LoadConfig;
import com.kunyihua.crafte.craftclass.CustomItem;
import java.io.PrintStream;
import java.util.*;
import org.bukkit.Server;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;

// Referenced classes of package com.kunyihua.crafte:
//            Main

public class GlobalVar
{

    public GlobalVar()
    {
    }

    public static void Print(String msg)
    {
        System.out.print((new StringBuilder(String.valueOf(detailStr))).append(msg).toString());
    }

    public static ItemMeta PutSpecialEffects(String ItemName, ItemMeta BaseItemMeta)
    {
        ItemMeta rItemMeta = BaseItemMeta;
        List returnItemLores = new ArrayList();
        if(BaseItemMeta.hasLore())
            returnItemLores = BaseItemMeta.getLore();
        if(SpecialEffectsMap.containsKey(ItemName.replace(" ", "_")))
        {
            List lstSpecialEffects = new ArrayList();
            lstSpecialEffects.addAll((Collection)SpecialEffectsMap.get(ItemName.replace(" ", "_")));
            for(int i = 0; i < lstSpecialEffects.size(); i++)
            {
                String strSpecialEffects[] = (String[])lstSpecialEffects.get(i);
                if(SpecialEffectsMsgMap.containsKey(strSpecialEffects[0]))
                    if(strSpecialEffects.length == 2)
                        returnItemLores.add(String.format((String)SpecialEffectsMsgMap.get(strSpecialEffects[0]), new Object[] {
                            strSpecialEffects[1]
                        }));
                    else
                    if(strSpecialEffects.length == 3)
                        returnItemLores.add(String.format((String)SpecialEffectsMsgMap.get(strSpecialEffects[0]), new Object[] {
                            strSpecialEffects[1], strSpecialEffects[2]
                        }));
            }

        }
        rItemMeta.setLore(returnItemLores);
        return rItemMeta;
    }

    public static ItemStack GetItemByKey(String ItemKey)
    {
        ItemStack giveItem = null;
        for(Iterator iterator = CustomItemMap.values().iterator(); iterator.hasNext();)
        {
            CustomItem item = (CustomItem)iterator.next();
            if(item.ItemKey.equals(ItemKey))
            {
                giveItem = new ItemStack(item.getResultItem());
                giveItem.setItemMeta(PutSpecialEffects(item.ItemName, giveItem.getItemMeta()));
                break;
            }
        }

        return giveItem;
    }

    public static String GetDefaultName(int itemId)
    {
        switch(itemId)
        {
        case 0: // '\0'
            return "\u7A7A\u6C23";

        case 1: // '\001'
            return "\u77F3\u982D";

        case 2: // '\002'
            return "\u8349";

        case 3: // '\003'
            return "\u6CE5\u571F";

        case 4: // '\004'
            return "\u5713\u77F3";

        case 5: // '\005'
            return "\u6728\u677F";

        case 6: // '\006'
            return "\u6A39\u82D7";

        case 7: // '\007'
            return "\u57FA\u5CA9";

        case 8: // '\b'
            return "\u6C34";

        case 9: // '\t'
            return "\u975C\u6B62\u7684\u6C34";

        case 10: // '\n'
            return "\u5CA9\u6F3F";

        case 11: // '\013'
            return "\u975C\u6B62\u7684\u5CA9\u6F3F";

        case 12: // '\f'
            return "\u6C99\u5B50";

        case 13: // '\r'
            return "\u6C99\u792B";

        case 14: // '\016'
            return "\u91D1\u7926\u77F3";

        case 15: // '\017'
            return "\u9435\u7926\u77F3";

        case 16: // '\020'
            return "\u7164\u7926\u77F3";

        case 17: // '\021'
            return "\u6728\u982D";

        case 18: // '\022'
            return "\u6A39\u8449";

        case 19: // '\023'
            return "\u6D77\u7DBF";

        case 20: // '\024'
            return "\u73BB\u7483";

        case 21: // '\025'
            return "\u9752\u91D1\u77F3\u7926\u77F3";

        case 22: // '\026'
            return "\u9752\u91D1\u77F3\u584A";

        case 23: // '\027'
            return "\u767C\u5C04\u5668";

        case 24: // '\030'
            return "\u6C99\u77F3";

        case 25: // '\031'
            return "\u97F3\u7B26\u76D2";

        case 26: // '\032'
            return "\u5E8A";

        case 27: // '\033'
            return "\u5145\u80FD\u9435\u8ECC";

        case 28: // '\034'
            return "\u63A2\u6E2C\u9435\u8ECC";

        case 29: // '\035'
            return "\u7C98\u6027\u6D3B\u585E";

        case 30: // '\036'
            return "\u8718\u86DB\u7DB2";

        case 31: // '\037'
            return "\u8349\u53E2";

        case 32: // ' '
            return "\u67AF\u6B7B\u7684\u704C\u6728";

        case 33: // '!'
            return "\u6D3B\u585E";

        case 34: // '"'
            return "\u6D3B\u585E\u81C2";

        case 35: // '#'
            return "\u7F8A\u6BDB";

        case 36: // '$'
            return "\u7531\u6D3B\u585E\u6240\u79FB\u52D5\u7684\u65B9\u584A";

        case 37: // '%'
            return "\u84B2\u516C\u82F1";

        case 38: // '&'
            return "\u73AB\u7470";

        case 39: // '\''
            return "\u7CBD\u8272\u8611\u83C7";

        case 40: // '('
            return "\u7D05\u8272\u8611\u83C7";

        case 41: // ')'
            return "\u91D1\u584A";

        case 42: // '*'
            return "\u9435\u584A";

        case 43: // '+'
            return "\u96D9\u53F0\u968E";

        case 44: // ','
            return "\u53F0\u968E";

        case 45: // '-'
            return "\u78DA\u584A";

        case 46: // '.'
            return "N";

        case 47: // '/'
            return "\u66F8\u67B6";

        case 48: // '0'
            return "\u82D4\u77F3";

        case 49: // '1'
            return "\u9ED1\u66DC\u77F3";

        case 50: // '2'
            return "\u706B\u628A";

        case 51: // '3'
            return "\u706B";

        case 52: // '4'
            return "\u5237\u602A\u7BB1";

        case 53: // '5'
            return "\u6728\u6A13\u68AF";

        case 54: // '6'
            return "\u7BB1\u5B50";

        case 55: // '7'
            return "\u7D05\u77F3\u7DDA";

        case 56: // '8'
            return "\u947D\u77F3\u7926\u77F3";

        case 57: // '9'
            return "\u947D\u77F3\u584A";

        case 58: // ':'
            return "\u5DE5\u4F5C\u53F0";

        case 59: // ';'
            return "\u5C0F\u9EA5\u7A2E\u5B50";

        case 60: // '<'
            return "\u8015\u5730";

        case 61: // '='
            return "\u7194\u7210";

        case 62: // '>'
            return "\u71C3\u71D2\u4E2D\u7684\u7194\u7210";

        case 63: // '?'
            return "\u544A\u793A\u724C";

        case 64: // '@'
            return "\u6728\u9580";

        case 65: // 'A'
            return "\u68AF\u5B50";

        case 66: // 'B'
            return "\u9435\u8ECC";

        case 67: // 'C'
            return "\u5713\u77F3\u6A13\u68AF";

        case 68: // 'D'
            return "\u7246\u4E0A\u7684\u544A\u793A\u724C";

        case 69: // 'E'
            return "\u62C9\u6746";

        case 70: // 'F'
            return "\u77F3\u8CEA\u58D3\u529B\u677F";

        case 71: // 'G'
            return "\u9435\u9580";

        case 72: // 'H'
            return "\u6728\u8CEA\u58D3\u529B\u677F";

        case 73: // 'I'
            return "\u7D05\u77F3\u7926\u77F3";

        case 74: // 'J'
            return "\u767C\u5149\u7684\u7D05\u77F3\u7926\u77F3";

        case 75: // 'K'
            return "\u7D05\u77F3\u706B\u628A(\u95DC\u9589)";

        case 76: // 'L'
            return "\u7D05\u77F3\u706B\u628A(\u958B\u555F)";

        case 77: // 'M'
            return "\u6309\u9215";

        case 78: // 'N'
            return "\u96EA";

        case 79: // 'O'
            return "\u51B0";

        case 80: // 'P'
            return "\u96EA\u584A";

        case 81: // 'Q'
            return "\u4ED9\u4EBA\u638C";

        case 82: // 'R'
            return "\u7C98\u571F\u584A";

        case 83: // 'S'
            return "\u7518\u8517";

        case 84: // 'T'
            return "\u5531\u7247\u6A5F";

        case 85: // 'U'
            return "\u67F5\u6B04";

        case 86: // 'V'
            return "\u5357\u74DC";

        case 87: // 'W'
            return "\u5730\u7344\u5CA9";

        case 88: // 'X'
            return "\u9748\u9B42\u6C99";

        case 89: // 'Y'
            return "\u87A2\u77F3";

        case 90: // 'Z'
            return "\u50B3\u9001\u9580\u65B9\u584A";

        case 91: // '['
            return "\u5357\u74DC\u71C8";

        case 92: // '\\'
            return "\u86CB\u7CD5";

        case 93: // ']'
            return "\u7D05\u77F3\u4E2D\u7E7C\u5668(\u95DC\u9589)";

        case 94: // '^'
            return "\u7D05\u77F3\u4E2D\u7E7C\u5668(\u958B\u555F)";

        case 95: // '_'
            return "\u4E0A\u9396\u7684\u7BB1\u5B50";

        case 96: // '`'
            return "\u6D3B\u677F\u9580";

        case 97: // 'a'
            return "?\u85CF\u7684\u8839\u87F2";

        case 98: // 'b'
            return "\u77F3\u78DA";

        case 99: // 'c'
            return "\u7CBD\u8272\u5DE8\u578B\u8611\u83C7";

        case 100: // 'd'
            return "\u7D05\u8272\u5DE8\u578B\u8611\u83C7";

        case 101: // 'e'
            return "\u9435\u6B04\u6746";

        case 102: // 'f'
            return "\u73BB\u7483\u677F";

        case 103: // 'g'
            return "\u897F\u74DC";

        case 104: // 'h'
            return "\u5357\u74DC\u6897";

        case 105: // 'i'
            return "\u897F\u74DC\u6897";

        case 106: // 'j'
            return "\u85E4\u8513";

        case 107: // 'k'
            return "\u67F5\u6B04\u9580";

        case 108: // 'l'
            return "\u78DA\u6A13\u68AF";

        case 109: // 'm'
            return "\u77F3\u78DA\u6A13\u68AF";

        case 110: // 'n'
            return "\u83CC\u7D72";

        case 111: // 'o'
            return "\u7761\u84EE";

        case 112: // 'p'
            return "\u5730\u7344\u78DA\u584A";

        case 113: // 'q'
            return "\u5730\u7344\u78DA\u67F5\u6B04";

        case 114: // 'r'
            return "\u5730\u7344\u78DA\u6A13\u68AF";

        case 115: // 's'
            return "\u5730\u7344\u75A3";

        case 116: // 't'
            return "\u9644\u9B54\u53F0";

        case 117: // 'u'
            return "\u91C0\u9020\u53F0";

        case 118: // 'v'
            return "\u7149\u85E5\u934B";

        case 119: // 'w'
            return "\u672B\u5730\u50B3\u9001\u9580\u65B9\u584A";

        case 120: // 'x'
            return "\u672B\u5730\u50B3\u9001\u9580\u6846\u67B6";

        case 121: // 'y'
            return "\u672B\u5730\u77F3";

        case 122: // 'z'
            return "\u9F8D\u86CB";

        case 123: // '{'
            return "\u7D05\u77F3\u71C8(\u95DC\u9589\u72C0\u614B)";

        case 124: // '|'
            return "\u7D05\u77F3\u71C8(\u958B\u555F\u72C0\u614B)";

        case 125: // '}'
            return "\u96D9\u6728\u53F0\u968E";

        case 126: // '~'
            return "\u6728\u53F0\u968E";

        case 127: // '\177'
            return "\u53EF\u53EF\u679C";

        case 128: 
            return "\u6C99\u77F3\u6A13\u68AF";

        case 129: 
            return "\u7DA0\u5BF6\u77F3\u7926\u77F3";

        case 130: 
            return "\u672B\u5F71\u7BB1";

        case 131: 
            return "\u7D46\u7DDA\u9264";

        case 132: 
            return "\u7D46\u7DDA";

        case 133: 
            return "\u7DA0\u5BF6\u77F3\u584A";

        case 134: 
            return "\u96F2\u6749\u6728\u6A13\u68AF";

        case 135: 
            return "\u6A3A\u6728\u6A13\u68AF";

        case 136: 
            return "\u53E2\u6797\u6728\u6A13\u68AF";

        case 137: 
            return "\u547D\u4EE4\u65B9\u584A";

        case 138: 
            return "\u4FE1\u6A19";

        case 139: 
            return "\u5713\u77F3\u7246";

        case 140: 
            return "\u82B1\u76C6";

        case 141: 
            return "\u80E1\u863F\u8514";

        case 142: 
            return "\u99AC\u9234\u85AF";

        case 143: 
            return "\u6728\u8CEA\u6309\u9215";

        case 144: 
            return "\u982D";

        case 145: 
            return "\u9435\u7827";

        case 146: 
            return "\u9677\u9631\u7BB1";

        case 147: 
            return "\u6E2C\u91CD\u58D3\u529B\u677F(\u8F15\u8CEA)";

        case 148: 
            return "\u6E2C\u91CD\u58D3\u529B\u677F(\u91CD\u8CEA)";

        case 149: 
            return "\u7D05\u77F3\u6BD4\u8F03\u5668(\u95DC\u9589)";

        case 150: 
            return "\u7D05\u77F3\u6BD4\u8F03\u5668(\u958B\u555F)";

        case 151: 
            return "\u967D\u5149\u611F\u6E2C\u5668";

        case 152: 
            return "\u7D05\u77F3\u584A";

        case 153: 
            return "\u4E0B\u754C\u77F3\u82F1\u7926\u77F3";

        case 154: 
            return "\u6F0F\u6597";

        case 155: 
            return "\u4E0B\u754C\u77F3\u82F1\u584A";

        case 156: 
            return "\u4E0B\u754C\u77F3\u82F1\u6A13\u68AF";

        case 157: 
            return "\u6FC0\u6D3B\u9435\u8ECC";

        case 158: 
            return "\u6295\u64F2\u5668";

        case 256: 
            return "\u9435\u936C";

        case 257: 
            return "\u9435\u93AC";

        case 258: 
            return "\u9435\u65A7";

        case 259: 
            return "\u6253\u706B\u77F3";

        case 260: 
            return "\u7D05\u860B\u679C";

        case 261: 
            return "\u5F13";

        case 262: 
            return "\u7BAD";

        case 263: 
            return "\u7164\u70AD";

        case 264: 
            return "\u947D\u77F3";

        case 265: 
            return "\u9435\u9320";

        case 266: 
            return "\u91D1\u9320";

        case 267: 
            return "\u9435\u528D";

        case 268: 
            return "\u6728\u528D";

        case 269: 
            return "\u6728\u936C";

        case 270: 
            return "\u6728\u93AC";

        case 271: 
            return "\u6728\u65A7";

        case 272: 
            return "\u77F3\u528D";

        case 273: 
            return "\u77F3\u936C";

        case 274: 
            return "\u77F3\u93AC";

        case 275: 
            return "\u77F3\u65A7";

        case 276: 
            return "\u947D\u77F3\u528D";

        case 277: 
            return "\u947D\u77F3\u936C";

        case 278: 
            return "\u947D\u77F3\u93AC";

        case 279: 
            return "\u947D\u77F3\u65A7";

        case 280: 
            return "\u6728\u68CD";

        case 281: 
            return "\u7897";

        case 282: 
            return "\u8611\u83C7\u7172";

        case 283: 
            return "\u91D1\u528D";

        case 284: 
            return "\u91D1\u936C";

        case 285: 
            return "\u91D1\u93AC";

        case 286: 
            return "\u91D1\u65A7";

        case 287: 
            return "\u7DDA";

        case 288: 
            return "\u7FBD\u6BDB";

        case 289: 
            return "\u706B\u85E5";

        case 290: 
            return "\u6728\u92E4";

        case 291: 
            return "\u77F3\u92E4";

        case 292: 
            return "\u9435\u92E4";

        case 293: 
            return "\u947D\u77F3\u92E4";

        case 294: 
            return "\u91D1\u92E4";

        case 295: 
            return "\u5C0F\u9EA5\u7A2E\u5B50";

        case 296: 
            return "\u5C0F\u9EA5";

        case 297: 
            return "\u9EB5\u5305";

        case 298: 
            return "\u76AE\u9769\u5E3D\u5B50";

        case 299: 
            return "\u76AE\u9769\u5916\u8863";

        case 300: 
            return "\u76AE\u9769\u8932\u5B50";

        case 301: 
            return "\u76AE\u9769\u9774";

        case 302: 
            return "\u93C8\u7532\u982D\u76D4";

        case 303: 
            return "\u93C8\u7532\u80F8\u7532";

        case 304: 
            return "\u93C8\u7532\u8B77\u817F";

        case 305: 
            return "\u93C8\u7532\u9774\u5B50";

        case 306: 
            return "\u9435\u982D\u76D4";

        case 307: 
            return "\u9435\u80F8\u7532";

        case 308: 
            return "\u9435\u8B77\u817F";

        case 309: 
            return "\u9435\u9774\u5B50";

        case 310: 
            return "\u947D\u77F3\u982D\u76D4";

        case 311: 
            return "\u947D\u77F3\u80F8\u7532";

        case 312: 
            return "\u947D\u77F3\u8B77\u817F";

        case 313: 
            return "\u947D\u77F3\u9774\u5B50";

        case 314: 
            return "\u91D1\u982D\u76D4";

        case 315: 
            return "\u91D1\u80F8\u7532";

        case 316: 
            return "\u91D1\u8B77\u817F";

        case 317: 
            return "\u91D1\u9774\u5B50";

        case 318: 
            return "\u71E7\u77F3";

        case 319: 
            return "\u751F\u8C6C\u6392";

        case 320: 
            return "\u719F\u8C6C\u6392";

        case 321: 
            return "\u756B";

        case 322: 
            return "\u91D1\u860B\u679C";

        case 323: 
            return "\u544A\u793A\u724C";

        case 324: 
            return "\u6728\u9580";

        case 325: 
            return "\u6876";

        case 326: 
            return "\u6C34\u6876";

        case 327: 
            return "\u5CA9\u6F3F\u6876";

        case 328: 
            return "\u7926\u8ECA";

        case 329: 
            return "\u978D";

        case 330: 
            return "\u9435\u9580";

        case 331: 
            return "\u7D05\u77F3\u7C89";

        case 332: 
            return "\u96EA\u7403";

        case 333: 
            return "\u8239";

        case 334: 
            return "\u76AE\u9769";

        case 335: 
            return "\u725B\u5976";

        case 336: 
            return "\u7D05\u78DA";

        case 337: 
            return "\u7C98\u571F";

        case 338: 
            return "\u7518\u8517";

        case 339: 
            return "\u7D19";

        case 340: 
            return "\u66F8";

        case 341: 
            return "\u7C98\u6DB2\u7403";

        case 342: 
            return "\u904B\u8F38\u7926\u8ECA";

        case 343: 
            return "\u52D5\u529B\u7926\u8ECA";

        case 344: 
            return "\u86CB";

        case 345: 
            return "\u6307\u5357\u91DD";

        case 346: 
            return "\u91E3\u9B5A\u7AFF";

        case 347: 
            return "\u937E";

        case 348: 
            return "\u87A2\u77F3\u7C89";

        case 349: 
            return "\u751F\u9B5A";

        case 350: 
            return "\u719F\u9B5A";

        case 351: 
            return "\u67D3\u6599";

        case 352: 
            return "\u9AA8\u982D";

        case 353: 
            return "\u7CD6";

        case 354: 
            return "\u86CB\u7CD5";

        case 355: 
            return "\u5E8A";

        case 356: 
            return "\u7D05\u77F3\u4E2D\u7E7C\u5668";

        case 357: 
            return "\u66F2\u5947";

        case 358: 
            return "\u5730\u5716";

        case 359: 
            return "\u526A\u5200";

        case 360: 
            return "\u897F\u74DC\u7247";

        case 361: 
            return "\u5357\u74DC\u7A2E\u5B50";

        case 362: 
            return "\u897F\u74DC\u7A2E\u5B50";

        case 363: 
            return "\u751F\u725B\u8089";

        case 364: 
            return "\u725B\u6392";

        case 365: 
            return "\u751F\u96DE\u8089";

        case 366: 
            return "\u719F\u96DE\u8089";

        case 367: 
            return "\u8150\u8089";

        case 368: 
            return "\u672B\u5F71\u73CD\u73E0";

        case 369: 
            return "\u70C8\u7130\u68D2";

        case 370: 
            return "\u60E1\u9B42\u4E4B\u6DDA";

        case 371: 
            return "\u91D1\u7C92";

        case 372: 
            return "\u5730\u7344\u75A3";

        case 373: 
            return "\u85E5\u6C34";

        case 374: 
            return "\u73BB\u7483\u74F6";

        case 375: 
            return "\u8718\u86DB\u773C";

        case 376: 
            return "\u767C\u9175\u86DB\u773C";

        case 377: 
            return "\u70C8\u7130\u7C89";

        case 378: 
            return "\u5CA9\u6F3F\u818F";

        case 379: 
            return "\u91C0\u9020\u53F0";

        case 380: 
            return "\u7149\u85E5\u934B";

        case 381: 
            return "\u672B\u5F71\u4E4B\u773C";

        case 382: 
            return "\u9583\u720D\u7684\u897F\u74DC";

        case 383: 
            return "\u5237\u602A\u86CB";

        case 384: 
            return "\u9644\u9B54\u4E4B\u74F6";

        case 385: 
            return "\u706B\u7403";

        case 386: 
            return "\u66F8\u8207\u7B46";

        case 387: 
            return "\u6210\u66F8";

        case 388: 
            return "\u7DA0\u5BF6\u77F3";

        case 389: 
            return "\u7269\u54C1\u5C55\u793A\u6846";

        case 390: 
            return "\u82B1\u76C6";

        case 391: 
            return "\u80E1\u863F\u8514";

        case 392: 
            return "\u99AC\u9234\u85AF";

        case 393: 
            return "\u70E4\u99AC\u9234\u85AF";

        case 394: 
            return "\u6BD2\u99AC\u9234\u85AF";

        case 395: 
            return "\u7A7A\u5730\u5716";

        case 396: 
            return "\u91D1\u80E1\u863F\u8514";

        case 397: 
            return "\u982D";

        case 398: 
            return "\u863F\u8514\u91E3\u7AFF";

        case 399: 
            return "\u4E0B\u754C\u4E4B\u661F";

        case 400: 
            return "\u5357\u74DC\u6D3E";

        case 401: 
            return "\u7159\u82B1\u706B\u7BAD";

        case 402: 
            return "\u7159\u706B\u4E4B\u661F";

        case 403: 
            return "\u9644\u9B54\u66F8";

        case 404: 
            return "\u7D05\u77F3\u6BD4\u8F03\u5668";

        case 405: 
            return "\u5730\u7344\u78DA";

        case 406: 
            return "\u4E0B\u754C\u77F3\u82F1";

        case 407: 
            return "N\u7926\u8ECA";

        case 408: 
            return "\u6F0F\u6597\u7926\u8ECA";

        case 2256: 
            return "13\u865F\u5531\u7247";

        case 2257: 
            return "ca\u5531\u7247";

        case 2258: 
            return "locks\u5531\u7247";

        case 2259: 
            return "chrp\u5531\u7247";

        case 2260: 
            return "far\u5531\u7247";

        case 2261: 
            return "mall\u5531\u7247";

        case 2262: 
            return "melloh\u5531\u7247";

        case 2263: 
            return "sal\u5531\u7247";

        case 2264: 
            return "sra\u5531\u7247";

        case 2265: 
            return "war\u5531\u7247";

        case 2266: 
            return "11\u865F\u5531\u7247";

        case 2267: 
            return "wa\u5531\u7247";
        }
        return "";
    }

    public static Main main;
    public static LoadConfig loadConfig;
    public static Server server;
    public static String detailStr = "[Kycraft]";
    public static String pluginMainDir = "./plugins/Kycraft/";
    public static List Msg_Success = new ArrayList();
    public static List Msg_Fail = new ArrayList();
    public static List Msg_Success_Personal = new ArrayList();
    public static List Msg_Fail_Personal = new ArrayList();
    public static int Talisman_ID = 339;
    public static Map CustomItemMap = new HashMap();
    public static Map TalismanItemMap = new HashMap();
    public static Map SpecialEffectsMap = new HashMap();
    public static Map SpecialEffectsMsgMap = new HashMap();
    public static Map PlayerArmorSEMap = new HashMap();
    public static Map PlayerAddHPMap = new HashMap();
    public static Map PlayerOnlineMap = new HashMap();
    public static Map MagicItemMap = new HashMap();

}

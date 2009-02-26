#include <stdio.h>
#include "prescheme.h"
#define TO_INTEGER(x) (long)(x)
#define TO_FLOAT(x) (double)(x)

void xfer_rect_32B(char *, long, long, long, char *, long, long, long, long, long);
void xfer_rect_24B(char *, long, long, long, char *, long, long, long, long, long);
void xfer_rect_16B(char *, long, long, long, char *, long, long, long, long, long);
void xfer_rect_8B(char *, long, long, long, char *, long, long, long, long, long);
void xfer_rect_32_24_beB(char *, long, long, long, char *, long, long, long, long, long);
void xfer_rect_32_24_leB(char *, long, long, long, char *, long, long, long, long, long);
void xfer_keyed_rect_32B(char *, long, long, long, char *, long, long, long, long, long, char *);
void xfer_keyed_rect_24B(char *, long, long, long, char *, long, long, long, long, long, char *);
void xfer_keyed_rect_16B(char *, long, long, long, char *, long, long, long, long, long, char *);
void xfer_keyed_rect_8B(char *, long, long, long, char *, long, long, long, long, long, char *);


void xfer_rect_32B(char * dest_image_0X, long dest_x_1X, long dest_y_2X, long dest_scan_length_3X, char * src_image_4X, long src_x_5X, long src_y_6X, long src_scan_length_7X, long size_x_8X, long size_y_9X)
{
  long arg0K0;
  long sp_14X;
  char * pixel_address_13X;
  char * destp_address_12X;
  long x_11X;
  long y_10X;
 {  arg0K0 = 0;
  goto L124;}
 L124: {
  y_10X = arg0K0;
  arg0K0 = 0;
  goto L128;}
 L128: {
  x_11X = arg0K0;
  if ((y_10X < size_y_9X)) {
    if ((x_11X < size_x_8X)) {
      destp_address_12X = dest_image_0X + (((dest_y_2X + y_10X) * dest_scan_length_3X) + ((((dest_x_1X + x_11X))<<13)));
      pixel_address_13X = src_image_4X + (((src_y_6X + y_10X) * src_scan_length_7X) + ((((src_x_5X + x_11X))<<13)));
      sp_14X = ((((((*((unsigned char *) pixel_address_13X)))<<24)) | ((((*((unsigned char *) (pixel_address_13X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_13X + 2))))<<8))) | (*((unsigned char *) (pixel_address_13X + 3)));
      *((unsigned char *) destp_address_12X) = (unsigned char) ((255 & ((long)(((unsigned long)sp_14X)>>24))));
      *((unsigned char *) (destp_address_12X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)sp_14X)>>16))));
      *((unsigned char *) (destp_address_12X + 2)) = (unsigned char) ((255 & ((long)(((unsigned long)sp_14X)>>8))));
      *((unsigned char *) (destp_address_12X + 3)) = (unsigned char) ((255 & sp_14X));
      arg0K0 = (1 + x_11X);
      goto L128;}
    else {
      arg0K0 = (1 + y_10X);
      goto L124;}}
  else {
    return;}}
}
void xfer_rect_24B(char * dest_image_15X, long dest_x_16X, long dest_y_17X, long dest_scan_length_18X, char * src_image_19X, long src_x_20X, long src_y_21X, long src_scan_length_22X, long size_x_23X, long size_y_24X)
{
  long arg0K0;
  long sp_29X;
  char * pixel_address_28X;
  char * destp_address_27X;
  long x_26X;
  long y_25X;
 {  arg0K0 = 0;
  goto L265;}
 L265: {
  y_25X = arg0K0;
  arg0K0 = 0;
  goto L269;}
 L269: {
  x_26X = arg0K0;
  if ((y_25X < size_y_24X)) {
    if ((x_26X < size_x_23X)) {
      destp_address_27X = dest_image_15X + (((dest_y_17X + y_25X) * dest_scan_length_18X) + (6144 * (dest_x_16X + x_26X)));
      pixel_address_28X = src_image_19X + (((src_y_21X + y_25X) * src_scan_length_22X) + (6144 * (src_x_20X + x_26X)));
      sp_29X = (((((*((unsigned char *) pixel_address_28X)))<<16)) | ((((*((unsigned char *) (pixel_address_28X + 1))))<<8))) | (*((unsigned char *) (pixel_address_28X + 2)));
      *((unsigned char *) destp_address_27X) = (unsigned char) ((255 & ((long)(((unsigned long)sp_29X)>>16))));
      *((unsigned char *) (destp_address_27X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)sp_29X)>>8))));
      *((unsigned char *) (destp_address_27X + 2)) = (unsigned char) ((255 & sp_29X));
      arg0K0 = (1 + x_26X);
      goto L269;}
    else {
      arg0K0 = (1 + y_25X);
      goto L265;}}
  else {
    return;}}
}
void xfer_rect_16B(char * dest_image_30X, long dest_x_31X, long dest_y_32X, long dest_scan_length_33X, char * src_image_34X, long src_x_35X, long src_y_36X, long src_scan_length_37X, long size_x_38X, long size_y_39X)
{
  long arg0K0;
  long sp_44X;
  char * pixel_address_43X;
  char * destp_address_42X;
  long x_41X;
  long y_40X;
 {  arg0K0 = 0;
  goto L404;}
 L404: {
  y_40X = arg0K0;
  arg0K0 = 0;
  goto L408;}
 L408: {
  x_41X = arg0K0;
  if ((y_40X < size_y_39X)) {
    if ((x_41X < size_x_38X)) {
      destp_address_42X = dest_image_30X + (((dest_y_32X + y_40X) * dest_scan_length_33X) + ((((dest_x_31X + x_41X))<<12)));
      pixel_address_43X = src_image_34X + (((src_y_36X + y_40X) * src_scan_length_37X) + ((((src_x_35X + x_41X))<<12)));
      sp_44X = ((((*((unsigned char *) pixel_address_43X)))<<8)) | (*((unsigned char *) (pixel_address_43X + 1)));
      *((unsigned char *) destp_address_42X) = (unsigned char) ((255 & ((long)(((unsigned long)sp_44X)>>8))));
      *((unsigned char *) (destp_address_42X + 1)) = (unsigned char) ((255 & sp_44X));
      arg0K0 = (1 + x_41X);
      goto L408;}
    else {
      arg0K0 = (1 + y_40X);
      goto L404;}}
  else {
    return;}}
}
void xfer_rect_8B(char * dest_image_45X, long dest_x_46X, long dest_y_47X, long dest_scan_length_48X, char * src_image_49X, long src_x_50X, long src_y_51X, long src_scan_length_52X, long size_x_53X, long size_y_54X)
{
  long arg0K0;
  long x_56X;
  long y_55X;
 {  arg0K0 = 0;
  goto L541;}
 L541: {
  y_55X = arg0K0;
  arg0K0 = 0;
  goto L545;}
 L545: {
  x_56X = arg0K0;
  if ((y_55X < size_y_54X)) {
    if ((x_56X < size_x_53X)) {
      *((unsigned char *) (dest_image_45X + (((dest_y_47X + y_55X) * dest_scan_length_48X) + ((((dest_x_46X + x_56X))<<11))))) = (unsigned char) ((255 & (*((unsigned char *) (src_image_49X + (((src_y_51X + y_55X) * src_scan_length_52X) + ((((src_x_50X + x_56X))<<11))))))));
      arg0K0 = (1 + x_56X);
      goto L545;}
    else {
      arg0K0 = (1 + y_55X);
      goto L541;}}
  else {
    return;}}
}
void xfer_rect_32_24_beB(char * dest_image_57X, long dest_x_58X, long dest_y_59X, long dest_scan_length_60X, char * src_image_61X, long src_x_62X, long src_y_63X, long src_scan_length_64X, long size_x_65X, long size_y_66X)
{
  long arg0K0;
  long i_71X;
  char * pixel_address_70X;
  char * destp_address_69X;
  long x_68X;
  long y_67X;
 {  arg0K0 = 0;
  goto L676;}
 L676: {
  y_67X = arg0K0;
  arg0K0 = 0;
  goto L680;}
 L680: {
  x_68X = arg0K0;
  if ((y_67X < size_y_66X)) {
    if ((x_68X < size_x_65X)) {
      destp_address_69X = dest_image_57X + (((dest_y_59X + y_67X) * dest_scan_length_60X) + (6144 * (dest_x_58X + x_68X)));
      pixel_address_70X = src_image_61X + (((src_y_63X + y_67X) * src_scan_length_64X) + ((((src_x_62X + x_68X))<<13)));
      i_71X = (long)(((unsigned long)(((((((*((unsigned char *) pixel_address_70X)))<<24)) | ((((*((unsigned char *) (pixel_address_70X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_70X + 2))))<<8))) | (*((unsigned char *) (pixel_address_70X + 3)))))>>8);
      *((unsigned char *) destp_address_69X) = (unsigned char) ((255 & ((long)(((unsigned long)i_71X)>>16))));
      *((unsigned char *) (destp_address_69X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_71X)>>8))));
      *((unsigned char *) (destp_address_69X + 2)) = (unsigned char) ((255 & i_71X));
      arg0K0 = (1 + x_68X);
      goto L680;}
    else {
      arg0K0 = (1 + y_67X);
      goto L676;}}
  else {
    return;}}
}
void xfer_rect_32_24_leB(char * dest_image_72X, long dest_x_73X, long dest_y_74X, long dest_scan_length_75X, char * src_image_76X, long src_x_77X, long src_y_78X, long src_scan_length_79X, long size_x_80X, long size_y_81X)
{
  long arg0K0;
  long i_86X;
  char * pixel_address_85X;
  char * destp_address_84X;
  long x_83X;
  long y_82X;
 {  arg0K0 = 0;
  goto L815;}
 L815: {
  y_82X = arg0K0;
  arg0K0 = 0;
  goto L819;}
 L819: {
  x_83X = arg0K0;
  if ((y_82X < size_y_81X)) {
    if ((x_83X < size_x_80X)) {
      destp_address_84X = dest_image_72X + (((dest_y_74X + y_82X) * dest_scan_length_75X) + (6144 * (dest_x_73X + x_83X)));
      pixel_address_85X = src_image_76X + (((src_y_78X + y_82X) * src_scan_length_79X) + ((((src_x_77X + x_83X))<<13)));
      i_86X = 16777215 & (((((((*((unsigned char *) pixel_address_85X)))<<24)) | ((((*((unsigned char *) (pixel_address_85X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_85X + 2))))<<8))) | (*((unsigned char *) (pixel_address_85X + 3))));
      *((unsigned char *) destp_address_84X) = (unsigned char) ((255 & ((long)(((unsigned long)i_86X)>>16))));
      *((unsigned char *) (destp_address_84X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_86X)>>8))));
      *((unsigned char *) (destp_address_84X + 2)) = (unsigned char) ((255 & i_86X));
      arg0K0 = (1 + x_83X);
      goto L819;}
    else {
      arg0K0 = (1 + y_82X);
      goto L815;}}
  else {
    return;}}
}
void xfer_keyed_rect_32B(char * dest_image_87X, long dest_x_88X, long dest_y_89X, long dest_scan_length_90X, char * src_image_91X, long src_x_92X, long src_y_93X, long src_scan_length_94X, long size_x_95X, long size_y_96X, char * key_address_97X)
{
  long arg0K0;
  long i_105X;
  long sp_104X;
  char * pixel_address_103X;
  long dp_102X;
  char * destp_address_101X;
  long x_100X;
  long y_99X;
  long kp_98X;
 {  kp_98X = ((((((*((unsigned char *) key_address_97X)))<<24)) | ((((*((unsigned char *) (key_address_97X + 1))))<<16))) | ((((*((unsigned char *) (key_address_97X + 2))))<<8))) | (*((unsigned char *) (key_address_97X + 3)));
  arg0K0 = 0;
  goto L971;}
 L971: {
  y_99X = arg0K0;
  arg0K0 = 0;
  goto L975;}
 L975: {
  x_100X = arg0K0;
  if ((y_99X < size_y_96X)) {
    if ((x_100X < size_x_95X)) {
      destp_address_101X = dest_image_87X + (((dest_y_89X + y_99X) * dest_scan_length_90X) + ((((dest_x_88X + x_100X))<<13)));
      dp_102X = ((((((*((unsigned char *) destp_address_101X)))<<24)) | ((((*((unsigned char *) (destp_address_101X + 1))))<<16))) | ((((*((unsigned char *) (destp_address_101X + 2))))<<8))) | (*((unsigned char *) (destp_address_101X + 3)));
      pixel_address_103X = src_image_91X + (((src_y_93X + y_99X) * src_scan_length_94X) + ((((src_x_92X + x_100X))<<13)));
      sp_104X = ((((((*((unsigned char *) pixel_address_103X)))<<24)) | ((((*((unsigned char *) (pixel_address_103X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_103X + 2))))<<8))) | (*((unsigned char *) (pixel_address_103X + 3)));
      if ((sp_104X == kp_98X)) {
        arg0K0 = dp_102X;
        goto L1016;}
      else {
        arg0K0 = sp_104X;
        goto L1016;}}
    else {
      arg0K0 = (1 + y_99X);
      goto L971;}}
  else {
    return;}}
 L1016: {
  i_105X = arg0K0;
  *((unsigned char *) destp_address_101X) = (unsigned char) ((255 & ((long)(((unsigned long)i_105X)>>24))));
  *((unsigned char *) (destp_address_101X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_105X)>>16))));
  *((unsigned char *) (destp_address_101X + 2)) = (unsigned char) ((255 & ((long)(((unsigned long)i_105X)>>8))));
  *((unsigned char *) (destp_address_101X + 3)) = (unsigned char) ((255 & i_105X));
  arg0K0 = (1 + x_100X);
  goto L975;}
}
void xfer_keyed_rect_24B(char * dest_image_106X, long dest_x_107X, long dest_y_108X, long dest_scan_length_109X, char * src_image_110X, long src_x_111X, long src_y_112X, long src_scan_length_113X, long size_x_114X, long size_y_115X, char * key_address_116X)
{
  long arg0K0;
  long i_124X;
  long sp_123X;
  char * pixel_address_122X;
  long dp_121X;
  char * destp_address_120X;
  long x_119X;
  long y_118X;
  long kp_117X;
 {  kp_117X = (((((*((unsigned char *) key_address_116X)))<<16)) | ((((*((unsigned char *) (key_address_116X + 1))))<<8))) | (*((unsigned char *) (key_address_116X + 2)));
  arg0K0 = 0;
  goto L1140;}
 L1140: {
  y_118X = arg0K0;
  arg0K0 = 0;
  goto L1144;}
 L1144: {
  x_119X = arg0K0;
  if ((y_118X < size_y_115X)) {
    if ((x_119X < size_x_114X)) {
      destp_address_120X = dest_image_106X + (((dest_y_108X + y_118X) * dest_scan_length_109X) + (6144 * (dest_x_107X + x_119X)));
      dp_121X = (((((*((unsigned char *) destp_address_120X)))<<16)) | ((((*((unsigned char *) (destp_address_120X + 1))))<<8))) | (*((unsigned char *) (destp_address_120X + 2)));
      pixel_address_122X = src_image_110X + (((src_y_112X + y_118X) * src_scan_length_113X) + (6144 * (src_x_111X + x_119X)));
      sp_123X = (((((*((unsigned char *) pixel_address_122X)))<<16)) | ((((*((unsigned char *) (pixel_address_122X + 1))))<<8))) | (*((unsigned char *) (pixel_address_122X + 2)));
      if ((sp_123X == kp_117X)) {
        arg0K0 = dp_121X;
        goto L1185;}
      else {
        arg0K0 = sp_123X;
        goto L1185;}}
    else {
      arg0K0 = (1 + y_118X);
      goto L1140;}}
  else {
    return;}}
 L1185: {
  i_124X = arg0K0;
  *((unsigned char *) destp_address_120X) = (unsigned char) ((255 & ((long)(((unsigned long)i_124X)>>16))));
  *((unsigned char *) (destp_address_120X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_124X)>>8))));
  *((unsigned char *) (destp_address_120X + 2)) = (unsigned char) ((255 & i_124X));
  arg0K0 = (1 + x_119X);
  goto L1144;}
}
void xfer_keyed_rect_16B(char * dest_image_125X, long dest_x_126X, long dest_y_127X, long dest_scan_length_128X, char * src_image_129X, long src_x_130X, long src_y_131X, long src_scan_length_132X, long size_x_133X, long size_y_134X, char * key_address_135X)
{
  long arg0K0;
  long i_143X;
  long sp_142X;
  char * pixel_address_141X;
  long dp_140X;
  char * destp_address_139X;
  long x_138X;
  long y_137X;
  long kp_136X;
 {  kp_136X = ((((*((unsigned char *) key_address_135X)))<<8)) | (*((unsigned char *) (key_address_135X + 1)));
  arg0K0 = 0;
  goto L1307;}
 L1307: {
  y_137X = arg0K0;
  arg0K0 = 0;
  goto L1311;}
 L1311: {
  x_138X = arg0K0;
  if ((y_137X < size_y_134X)) {
    if ((x_138X < size_x_133X)) {
      destp_address_139X = dest_image_125X + (((dest_y_127X + y_137X) * dest_scan_length_128X) + ((((dest_x_126X + x_138X))<<12)));
      dp_140X = ((((*((unsigned char *) destp_address_139X)))<<8)) | (*((unsigned char *) (destp_address_139X + 1)));
      pixel_address_141X = src_image_129X + (((src_y_131X + y_137X) * src_scan_length_132X) + ((((src_x_130X + x_138X))<<12)));
      sp_142X = ((((*((unsigned char *) pixel_address_141X)))<<8)) | (*((unsigned char *) (pixel_address_141X + 1)));
      if ((sp_142X == kp_136X)) {
        arg0K0 = dp_140X;
        goto L1352;}
      else {
        arg0K0 = sp_142X;
        goto L1352;}}
    else {
      arg0K0 = (1 + y_137X);
      goto L1307;}}
  else {
    return;}}
 L1352: {
  i_143X = arg0K0;
  *((unsigned char *) destp_address_139X) = (unsigned char) ((255 & ((long)(((unsigned long)i_143X)>>8))));
  *((unsigned char *) (destp_address_139X + 1)) = (unsigned char) ((255 & i_143X));
  arg0K0 = (1 + x_138X);
  goto L1311;}
}
void xfer_keyed_rect_8B(char * dest_image_144X, long dest_x_145X, long dest_y_146X, long dest_scan_length_147X, char * src_image_148X, long src_x_149X, long src_y_150X, long src_scan_length_151X, long size_x_152X, long size_y_153X, char * key_address_154X)
{
  long arg0K0;
  long i_161X;
  long sp_160X;
  long dp_159X;
  char * destp_address_158X;
  long x_157X;
  long y_156X;
  long kp_155X;
 {  kp_155X = *((unsigned char *) key_address_154X);
  arg0K0 = 0;
  goto L1472;}
 L1472: {
  y_156X = arg0K0;
  arg0K0 = 0;
  goto L1476;}
 L1476: {
  x_157X = arg0K0;
  if ((y_156X < size_y_153X)) {
    if ((x_157X < size_x_152X)) {
      destp_address_158X = dest_image_144X + (((dest_y_146X + y_156X) * dest_scan_length_147X) + ((((dest_x_145X + x_157X))<<11)));
      dp_159X = *((unsigned char *) destp_address_158X);
      sp_160X = *((unsigned char *) (src_image_148X + (((src_y_150X + y_156X) * src_scan_length_151X) + ((((src_x_149X + x_157X))<<11)))));
      if ((sp_160X == kp_155X)) {
        arg0K0 = dp_159X;
        goto L1517;}
      else {
        arg0K0 = sp_160X;
        goto L1517;}}
    else {
      arg0K0 = (1 + y_156X);
      goto L1472;}}
  else {
    return;}}
 L1517: {
  i_161X = arg0K0;
  *((unsigned char *) destp_address_158X) = (unsigned char) ((255 & i_161X));
  arg0K0 = (1 + x_157X);
  goto L1476;}
}

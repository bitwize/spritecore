#include <stdio.h>
#include "prescheme.h"
#define TO_INTEGER(x) (long)(x)
#define TO_FLOAT(x) (double)(x)

void xfer_rect_32B(char *, long, long, long, long, char *, long, long, long, long, long, long);
void xfer_rect_24B(char *, long, long, long, long, char *, long, long, long, long, long, long);
void xfer_rect_16B(char *, long, long, long, long, char *, long, long, long, long, long, long);
void xfer_rect_8B(char *, long, long, long, long, char *, long, long, long, long, long, long);
void xfer_rect_32_24_beB(char *, long, long, long, long, char *, long, long, long, long, long, long);
void xfer_rect_32_24_leB(char *, long, long, long, long, char *, long, long, long, long, long, long);
void xfer_keyed_rect_32B(char *, long, long, long, long, char *, long, long, long, long, long, long, char *);
void xfer_keyed_rect_24B(char *, long, long, long, long, char *, long, long, long, long, long, long, char *);
void xfer_keyed_rect_16B(char *, long, long, long, long, char *, long, long, long, long, long, long, char *);
void xfer_keyed_rect_8B(char *, long, long, long, long, char *, long, long, long, long, long, long, char *);


void xfer_rect_32B(char * dest_image_0X, long dest_x_1X, long dest_y_2X, long dest_pixel_size_3X, long dest_scan_length_4X, char * src_image_5X, long src_x_6X, long src_y_7X, long src_pixel_size_8X, long src_scan_length_9X, long size_x_10X, long size_y_11X)
{
  long arg0K0;
  long sp_16X;
  char * pixel_address_15X;
  char * da_14X;
  long x_13X;
  long y_12X;
 {  arg0K0 = 0;
  goto L126;}
 L126: {
  y_12X = arg0K0;
  arg0K0 = 0;
  goto L130;}
 L130: {
  x_13X = arg0K0;
  if ((y_12X < size_y_11X)) {
    if ((x_13X < size_x_10X)) {
      da_14X = dest_image_0X + (((dest_y_2X + y_12X) * dest_scan_length_4X) + ((dest_x_1X + x_13X) * dest_pixel_size_3X));
      pixel_address_15X = src_image_5X + (((src_y_7X + y_12X) * src_scan_length_9X) + ((src_x_6X + x_13X) * src_pixel_size_8X));
      sp_16X = ((((((*((unsigned char *) pixel_address_15X)))<<24)) | ((((*((unsigned char *) (pixel_address_15X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_15X + 2))))<<8))) | (*((unsigned char *) (pixel_address_15X + 3)));
      *((unsigned char *) da_14X) = (unsigned char) ((255 & ((long)(((unsigned long)sp_16X)>>24))));
      *((unsigned char *) (da_14X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)sp_16X)>>16))));
      *((unsigned char *) (da_14X + 2)) = (unsigned char) ((255 & ((long)(((unsigned long)sp_16X)>>8))));
      *((unsigned char *) (da_14X + 3)) = (unsigned char) ((255 & sp_16X));
      arg0K0 = (1 + x_13X);
      goto L130;}
    else {
      arg0K0 = (1 + y_12X);
      goto L126;}}
  else {
    return;}}
}
void xfer_rect_24B(char * dest_image_17X, long dest_x_18X, long dest_y_19X, long dest_pixel_size_20X, long dest_scan_length_21X, char * src_image_22X, long src_x_23X, long src_y_24X, long src_pixel_size_25X, long src_scan_length_26X, long size_x_27X, long size_y_28X)
{
  long arg0K0;
  long sp_33X;
  char * pixel_address_32X;
  char * da_31X;
  long x_30X;
  long y_29X;
 {  arg0K0 = 0;
  goto L265;}
 L265: {
  y_29X = arg0K0;
  arg0K0 = 0;
  goto L269;}
 L269: {
  x_30X = arg0K0;
  if ((y_29X < size_y_28X)) {
    if ((x_30X < size_x_27X)) {
      da_31X = dest_image_17X + (((dest_y_19X + y_29X) * dest_scan_length_21X) + ((dest_x_18X + x_30X) * dest_pixel_size_20X));
      pixel_address_32X = src_image_22X + (((src_y_24X + y_29X) * src_scan_length_26X) + ((src_x_23X + x_30X) * src_pixel_size_25X));
      sp_33X = (((((*((unsigned char *) pixel_address_32X)))<<16)) | ((((*((unsigned char *) (pixel_address_32X + 1))))<<8))) | (*((unsigned char *) (pixel_address_32X + 2)));
      *((unsigned char *) da_31X) = (unsigned char) ((255 & ((long)(((unsigned long)sp_33X)>>16))));
      *((unsigned char *) (da_31X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)sp_33X)>>8))));
      *((unsigned char *) (da_31X + 2)) = (unsigned char) ((255 & sp_33X));
      arg0K0 = (1 + x_30X);
      goto L269;}
    else {
      arg0K0 = (1 + y_29X);
      goto L265;}}
  else {
    return;}}
}
void xfer_rect_16B(char * dest_image_34X, long dest_x_35X, long dest_y_36X, long dest_pixel_size_37X, long dest_scan_length_38X, char * src_image_39X, long src_x_40X, long src_y_41X, long src_pixel_size_42X, long src_scan_length_43X, long size_x_44X, long size_y_45X)
{
  long arg0K0;
  long sp_50X;
  char * pixel_address_49X;
  char * da_48X;
  long x_47X;
  long y_46X;
 {  arg0K0 = 0;
  goto L402;}
 L402: {
  y_46X = arg0K0;
  arg0K0 = 0;
  goto L406;}
 L406: {
  x_47X = arg0K0;
  if ((y_46X < size_y_45X)) {
    if ((x_47X < size_x_44X)) {
      da_48X = dest_image_34X + (((dest_y_36X + y_46X) * dest_scan_length_38X) + ((dest_x_35X + x_47X) * dest_pixel_size_37X));
      pixel_address_49X = src_image_39X + (((src_y_41X + y_46X) * src_scan_length_43X) + ((src_x_40X + x_47X) * src_pixel_size_42X));
      sp_50X = ((((*((unsigned char *) pixel_address_49X)))<<8)) | (*((unsigned char *) (pixel_address_49X + 1)));
      *((unsigned char *) da_48X) = (unsigned char) ((255 & ((long)(((unsigned long)sp_50X)>>8))));
      *((unsigned char *) (da_48X + 1)) = (unsigned char) ((255 & sp_50X));
      arg0K0 = (1 + x_47X);
      goto L406;}
    else {
      arg0K0 = (1 + y_46X);
      goto L402;}}
  else {
    return;}}
}
void xfer_rect_8B(char * dest_image_51X, long dest_x_52X, long dest_y_53X, long dest_pixel_size_54X, long dest_scan_length_55X, char * src_image_56X, long src_x_57X, long src_y_58X, long src_pixel_size_59X, long src_scan_length_60X, long size_x_61X, long size_y_62X)
{
  long arg0K0;
  long x_64X;
  long y_63X;
 {  arg0K0 = 0;
  goto L537;}
 L537: {
  y_63X = arg0K0;
  arg0K0 = 0;
  goto L541;}
 L541: {
  x_64X = arg0K0;
  if ((y_63X < size_y_62X)) {
    if ((x_64X < size_x_61X)) {
      *((unsigned char *) (dest_image_51X + (((dest_y_53X + y_63X) * dest_scan_length_55X) + ((dest_x_52X + x_64X) * dest_pixel_size_54X)))) = (unsigned char) ((255 & (*((unsigned char *) (src_image_56X + (((src_y_58X + y_63X) * src_scan_length_60X) + ((src_x_57X + x_64X) * src_pixel_size_59X)))))));
      arg0K0 = (1 + x_64X);
      goto L541;}
    else {
      arg0K0 = (1 + y_63X);
      goto L537;}}
  else {
    return;}}
}
void xfer_rect_32_24_beB(char * dest_image_65X, long dest_x_66X, long dest_y_67X, long dest_pixel_size_68X, long dest_scan_length_69X, char * src_image_70X, long src_x_71X, long src_y_72X, long src_pixel_size_73X, long src_scan_length_74X, long size_x_75X, long size_y_76X)
{
  long arg0K0;
  long i_81X;
  char * pixel_address_80X;
  char * da_79X;
  long x_78X;
  long y_77X;
 {  arg0K0 = 0;
  goto L670;}
 L670: {
  y_77X = arg0K0;
  arg0K0 = 0;
  goto L674;}
 L674: {
  x_78X = arg0K0;
  if ((y_77X < size_y_76X)) {
    if ((x_78X < size_x_75X)) {
      da_79X = dest_image_65X + (((dest_y_67X + y_77X) * dest_scan_length_69X) + ((dest_x_66X + x_78X) * dest_pixel_size_68X));
      pixel_address_80X = src_image_70X + (((src_y_72X + y_77X) * src_scan_length_74X) + ((src_x_71X + x_78X) * src_pixel_size_73X));
      i_81X = (long)(((unsigned long)(((((((*((unsigned char *) pixel_address_80X)))<<24)) | ((((*((unsigned char *) (pixel_address_80X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_80X + 2))))<<8))) | (*((unsigned char *) (pixel_address_80X + 3)))))>>8);
      *((unsigned char *) da_79X) = (unsigned char) ((255 & ((long)(((unsigned long)i_81X)>>16))));
      *((unsigned char *) (da_79X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_81X)>>8))));
      *((unsigned char *) (da_79X + 2)) = (unsigned char) ((255 & i_81X));
      arg0K0 = (1 + x_78X);
      goto L674;}
    else {
      arg0K0 = (1 + y_77X);
      goto L670;}}
  else {
    return;}}
}
void xfer_rect_32_24_leB(char * dest_image_82X, long dest_x_83X, long dest_y_84X, long dest_pixel_size_85X, long dest_scan_length_86X, char * src_image_87X, long src_x_88X, long src_y_89X, long src_pixel_size_90X, long src_scan_length_91X, long size_x_92X, long size_y_93X)
{
  long arg0K0;
  long i_98X;
  char * pixel_address_97X;
  char * da_96X;
  long x_95X;
  long y_94X;
 {  arg0K0 = 0;
  goto L807;}
 L807: {
  y_94X = arg0K0;
  arg0K0 = 0;
  goto L811;}
 L811: {
  x_95X = arg0K0;
  if ((y_94X < size_y_93X)) {
    if ((x_95X < size_x_92X)) {
      da_96X = dest_image_82X + (((dest_y_84X + y_94X) * dest_scan_length_86X) + ((dest_x_83X + x_95X) * dest_pixel_size_85X));
      pixel_address_97X = src_image_87X + (((src_y_89X + y_94X) * src_scan_length_91X) + ((src_x_88X + x_95X) * src_pixel_size_90X));
      i_98X = 16777215 & (((((((*((unsigned char *) pixel_address_97X)))<<24)) | ((((*((unsigned char *) (pixel_address_97X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_97X + 2))))<<8))) | (*((unsigned char *) (pixel_address_97X + 3))));
      *((unsigned char *) da_96X) = (unsigned char) ((255 & ((long)(((unsigned long)i_98X)>>16))));
      *((unsigned char *) (da_96X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_98X)>>8))));
      *((unsigned char *) (da_96X + 2)) = (unsigned char) ((255 & i_98X));
      arg0K0 = (1 + x_95X);
      goto L811;}
    else {
      arg0K0 = (1 + y_94X);
      goto L807;}}
  else {
    return;}}
}
void xfer_keyed_rect_32B(char * dest_image_99X, long dest_x_100X, long dest_y_101X, long dest_pixel_size_102X, long dest_scan_length_103X, char * src_image_104X, long src_x_105X, long src_y_106X, long src_pixel_size_107X, long src_scan_length_108X, long size_x_109X, long size_y_110X, char * key_address_111X)
{
  long arg0K0;
  long i_119X;
  long kp_118X;
  long dp_117X;
  long sp_116X;
  char * pixel_address_115X;
  char * da_114X;
  long x_113X;
  long y_112X;
 {  arg0K0 = 0;
  goto L959;}
 L959: {
  y_112X = arg0K0;
  arg0K0 = 0;
  goto L963;}
 L963: {
  x_113X = arg0K0;
  if ((y_112X < size_y_110X)) {
    if ((x_113X < size_x_109X)) {
      da_114X = dest_image_99X + (((dest_y_101X + y_112X) * dest_scan_length_103X) + ((dest_x_100X + x_113X) * dest_pixel_size_102X));
      pixel_address_115X = src_image_104X + (((src_y_106X + y_112X) * src_scan_length_108X) + ((src_x_105X + x_113X) * src_pixel_size_107X));
      sp_116X = ((((((*((unsigned char *) pixel_address_115X)))<<24)) | ((((*((unsigned char *) (pixel_address_115X + 1))))<<16))) | ((((*((unsigned char *) (pixel_address_115X + 2))))<<8))) | (*((unsigned char *) (pixel_address_115X + 3)));
      dp_117X = ((((((*((unsigned char *) da_114X)))<<24)) | ((((*((unsigned char *) (da_114X + 1))))<<16))) | ((((*((unsigned char *) (da_114X + 2))))<<8))) | (*((unsigned char *) (da_114X + 3)));
      kp_118X = ((((((*((unsigned char *) key_address_111X)))<<24)) | ((((*((unsigned char *) (key_address_111X + 1))))<<16))) | ((((*((unsigned char *) (key_address_111X + 2))))<<8))) | (*((unsigned char *) (key_address_111X + 3)));
      if ((sp_116X == kp_118X)) {
        arg0K0 = dp_117X;
        goto L1004;}
      else {
        arg0K0 = sp_116X;
        goto L1004;}}
    else {
      arg0K0 = (1 + y_112X);
      goto L959;}}
  else {
    return;}}
 L1004: {
  i_119X = arg0K0;
  *((unsigned char *) da_114X) = (unsigned char) ((255 & ((long)(((unsigned long)i_119X)>>24))));
  *((unsigned char *) (da_114X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_119X)>>16))));
  *((unsigned char *) (da_114X + 2)) = (unsigned char) ((255 & ((long)(((unsigned long)i_119X)>>8))));
  *((unsigned char *) (da_114X + 3)) = (unsigned char) ((255 & i_119X));
  arg0K0 = (1 + x_113X);
  goto L963;}
}
void xfer_keyed_rect_24B(char * dest_image_120X, long dest_x_121X, long dest_y_122X, long dest_pixel_size_123X, long dest_scan_length_124X, char * src_image_125X, long src_x_126X, long src_y_127X, long src_pixel_size_128X, long src_scan_length_129X, long size_x_130X, long size_y_131X, char * key_address_132X)
{
  long arg0K0;
  long i_140X;
  long kp_139X;
  long dp_138X;
  long sp_137X;
  char * pixel_address_136X;
  char * da_135X;
  long x_134X;
  long y_133X;
 {  arg0K0 = 0;
  goto L1128;}
 L1128: {
  y_133X = arg0K0;
  arg0K0 = 0;
  goto L1132;}
 L1132: {
  x_134X = arg0K0;
  if ((y_133X < size_y_131X)) {
    if ((x_134X < size_x_130X)) {
      da_135X = dest_image_120X + (((dest_y_122X + y_133X) * dest_scan_length_124X) + ((dest_x_121X + x_134X) * dest_pixel_size_123X));
      pixel_address_136X = src_image_125X + (((src_y_127X + y_133X) * src_scan_length_129X) + ((src_x_126X + x_134X) * src_pixel_size_128X));
      sp_137X = (((((*((unsigned char *) pixel_address_136X)))<<16)) | ((((*((unsigned char *) (pixel_address_136X + 1))))<<8))) | (*((unsigned char *) (pixel_address_136X + 2)));
      dp_138X = (((((*((unsigned char *) da_135X)))<<16)) | ((((*((unsigned char *) (da_135X + 1))))<<8))) | (*((unsigned char *) (da_135X + 2)));
      kp_139X = (((((*((unsigned char *) key_address_132X)))<<16)) | ((((*((unsigned char *) (key_address_132X + 1))))<<8))) | (*((unsigned char *) (key_address_132X + 2)));
      if ((sp_137X == kp_139X)) {
        arg0K0 = dp_138X;
        goto L1173;}
      else {
        arg0K0 = sp_137X;
        goto L1173;}}
    else {
      arg0K0 = (1 + y_133X);
      goto L1128;}}
  else {
    return;}}
 L1173: {
  i_140X = arg0K0;
  *((unsigned char *) da_135X) = (unsigned char) ((255 & ((long)(((unsigned long)i_140X)>>16))));
  *((unsigned char *) (da_135X + 1)) = (unsigned char) ((255 & ((long)(((unsigned long)i_140X)>>8))));
  *((unsigned char *) (da_135X + 2)) = (unsigned char) ((255 & i_140X));
  arg0K0 = (1 + x_134X);
  goto L1132;}
}
void xfer_keyed_rect_16B(char * dest_image_141X, long dest_x_142X, long dest_y_143X, long dest_pixel_size_144X, long dest_scan_length_145X, char * src_image_146X, long src_x_147X, long src_y_148X, long src_pixel_size_149X, long src_scan_length_150X, long size_x_151X, long size_y_152X, char * key_address_153X)
{
  long arg0K0;
  long i_161X;
  long kp_160X;
  long dp_159X;
  long sp_158X;
  char * pixel_address_157X;
  char * da_156X;
  long x_155X;
  long y_154X;
 {  arg0K0 = 0;
  goto L1295;}
 L1295: {
  y_154X = arg0K0;
  arg0K0 = 0;
  goto L1299;}
 L1299: {
  x_155X = arg0K0;
  if ((y_154X < size_y_152X)) {
    if ((x_155X < size_x_151X)) {
      da_156X = dest_image_141X + (((dest_y_143X + y_154X) * dest_scan_length_145X) + ((dest_x_142X + x_155X) * dest_pixel_size_144X));
      pixel_address_157X = src_image_146X + (((src_y_148X + y_154X) * src_scan_length_150X) + ((src_x_147X + x_155X) * src_pixel_size_149X));
      sp_158X = ((((*((unsigned char *) pixel_address_157X)))<<8)) | (*((unsigned char *) (pixel_address_157X + 1)));
      dp_159X = ((((*((unsigned char *) da_156X)))<<8)) | (*((unsigned char *) (da_156X + 1)));
      kp_160X = ((((*((unsigned char *) key_address_153X)))<<8)) | (*((unsigned char *) (key_address_153X + 1)));
      if ((sp_158X == kp_160X)) {
        arg0K0 = dp_159X;
        goto L1340;}
      else {
        arg0K0 = sp_158X;
        goto L1340;}}
    else {
      arg0K0 = (1 + y_154X);
      goto L1295;}}
  else {
    return;}}
 L1340: {
  i_161X = arg0K0;
  *((unsigned char *) da_156X) = (unsigned char) ((255 & ((long)(((unsigned long)i_161X)>>8))));
  *((unsigned char *) (da_156X + 1)) = (unsigned char) ((255 & i_161X));
  arg0K0 = (1 + x_155X);
  goto L1299;}
}
void xfer_keyed_rect_8B(char * dest_image_162X, long dest_x_163X, long dest_y_164X, long dest_pixel_size_165X, long dest_scan_length_166X, char * src_image_167X, long src_x_168X, long src_y_169X, long src_pixel_size_170X, long src_scan_length_171X, long size_x_172X, long size_y_173X, char * key_address_174X)
{
  long arg0K0;
  long i_181X;
  long kp_180X;
  long dp_179X;
  long sp_178X;
  char * da_177X;
  long x_176X;
  long y_175X;
 {  arg0K0 = 0;
  goto L1460;}
 L1460: {
  y_175X = arg0K0;
  arg0K0 = 0;
  goto L1464;}
 L1464: {
  x_176X = arg0K0;
  if ((y_175X < size_y_173X)) {
    if ((x_176X < size_x_172X)) {
      da_177X = dest_image_162X + (((dest_y_164X + y_175X) * dest_scan_length_166X) + ((dest_x_163X + x_176X) * dest_pixel_size_165X));
      sp_178X = *((unsigned char *) (src_image_167X + (((src_y_169X + y_175X) * src_scan_length_171X) + ((src_x_168X + x_176X) * src_pixel_size_170X))));
      dp_179X = *((unsigned char *) da_177X);
      kp_180X = *((unsigned char *) key_address_174X);
      if ((sp_178X == kp_180X)) {
        arg0K0 = dp_179X;
        goto L1505;}
      else {
        arg0K0 = sp_178X;
        goto L1505;}}
    else {
      arg0K0 = (1 + y_175X);
      goto L1460;}}
  else {
    return;}}
 L1505: {
  i_181X = arg0K0;
  *((unsigned char *) da_177X) = (unsigned char) ((255 & i_181X));
  arg0K0 = (1 + x_176X);
  goto L1464;}
}

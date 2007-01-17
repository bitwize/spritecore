#include <stdio.h>

#define TO_INTEGER(x) (long)(x)
#define TO_FLOAT(x) (double)(x)

struct rect {
  long left;
  long top;
  long right;
  long bottom;
};
static double xform_rect(double*, struct rect*, double*, double*, double*, double*, double*, double*, double*, struct rect**);
static struct rect *bound_quadB(double, double, double, double, double, double, double, double, struct rect*);
static char pt_in_rect(long, long, struct rect*);
void rect_intersectB(struct rect*, struct rect*, struct rect*);
void xfer_rectB(char *, long, long, long, char *, long, long, long, long, long, long);
struct rect *bound_xform_rectB(double*, struct rect*);
void xfer_keyed_rectB(char *, long, long, long, char *, long, long, long, long, long, char *, long);
void xfer_xformed_rectB(char *, long, char *, long, long, long, long, long, double*, struct rect*, long);
void xfer_xformed_keyed_rectB(char *, long, char *, long, long, long, long, long, double*, struct rect*, char *, long);
void xform_clipB(double*, double*, struct rect*, struct rect*, struct rect*, struct rect*);


static double xform_rect(double *mat_0X, struct rect *r_1X, double *TT0, double *TT1, double *TT2, double *TT3, double *TT4, double *TT5, double *TT6, struct rect **TT7)
{
  double y_24X;
  double x_23X;
  double v_22X;
  double y_21X;
  double x_20X;
  double v_19X;
  double y_18X;
  double x_17X;
  double v_16X;
  double y_15X;
  double x_14X;
  double v_13X;
  double y_12X;
  double x_11X;
  double v_10X;
  double y_9X;
  double x_8X;
  double v_7X;
  double y_6X;
  double x_5X;
  double v_4X;
  double y_3X;
  double x_2X;
 {  x_2X = TO_FLOAT((r_1X->right));
  y_3X = TO_FLOAT((r_1X->bottom));
  v_4X = (((*(mat_0X + 3)) * x_2X) + ((*(mat_0X + 4)) * y_3X)) + (*(mat_0X + 5));
  x_5X = TO_FLOAT((r_1X->right));
  y_6X = TO_FLOAT((r_1X->bottom));
  v_7X = (((*(mat_0X + 0)) * x_5X) + ((*(mat_0X + 1)) * y_6X)) + (*(mat_0X + 2));
  x_8X = TO_FLOAT((r_1X->left));
  y_9X = TO_FLOAT((r_1X->bottom));
  v_10X = (((*(mat_0X + 3)) * x_8X) + ((*(mat_0X + 4)) * y_9X)) + (*(mat_0X + 5));
  x_11X = TO_FLOAT((r_1X->left));
  y_12X = TO_FLOAT((r_1X->bottom));
  v_13X = (((*(mat_0X + 0)) * x_11X) + ((*(mat_0X + 1)) * y_12X)) + (*(mat_0X + 2));
  x_14X = TO_FLOAT((r_1X->right));
  y_15X = TO_FLOAT((r_1X->top));
  v_16X = (((*(mat_0X + 3)) * x_14X) + ((*(mat_0X + 4)) * y_15X)) + (*(mat_0X + 5));
  x_17X = TO_FLOAT((r_1X->right));
  y_18X = TO_FLOAT((r_1X->top));
  v_19X = (((*(mat_0X + 0)) * x_17X) + ((*(mat_0X + 1)) * y_18X)) + (*(mat_0X + 2));
  x_20X = TO_FLOAT((r_1X->left));
  y_21X = TO_FLOAT((r_1X->top));
  v_22X = (((*(mat_0X + 3)) * x_20X) + ((*(mat_0X + 4)) * y_21X)) + (*(mat_0X + 5));
  x_23X = TO_FLOAT((r_1X->left));
  y_24X = TO_FLOAT((r_1X->top));
  *TT0 = v_22X;
  *TT1 = v_19X;
  *TT2 = v_16X;
  *TT3 = v_13X;
  *TT4 = v_10X;
  *TT5 = v_7X;
  *TT6 = v_4X;
  *TT7 = r_1X;
  return ((((*(mat_0X + 0)) * x_23X) + ((*(mat_0X + 1)) * y_24X)) + (*(mat_0X + 2)));}
}
static struct rect *bound_quadB(double x1_25X, double y1_26X, double x2_27X, double y2_28X, double x3_29X, double y3_30X, double x4_31X, double y4_32X, struct rect *r_33X)
{
  long arg0K0;
  long merged_arg0K3;
  long merged_arg0K2;
  long merged_arg0K1;
  long merged_arg0K0;

  int max4_return_tag;
  long max40_return_value;
  int min4_return_tag;
  long min40_return_value;
  long a_34X;
  long b_35X;
  long c_36X;
  long d_37X;
  long a_38X;
  long b_39X;
  long c_40X;
  long d_41X;
  long x_65X;
  long x_64X;
  long x_63X;
  long x_62X;
  long x_61X;
  long v_60X;
  long v_59X;
  long v_58X;
  long v_57X;
  long x_56X;
  long v_55X;
  long v_54X;
  long v_53X;
  long v_52X;
  long x_51X;
  long v_50X;
  long v_49X;
  long v_48X;
  long v_47X;
  long x_46X;
  long v_45X;
  long v_44X;
  long v_43X;
  long v_42X;
 {  v_42X = TO_INTEGER(x2_27X);
  v_43X = TO_INTEGER(x4_31X);
  v_44X = TO_INTEGER(x1_25X);
  v_45X = TO_INTEGER(x3_29X);
  merged_arg0K0 = v_44X;
  merged_arg0K1 = v_42X;
  merged_arg0K2 = v_45X;
  merged_arg0K3 = v_43X;
  min4_return_tag = 0;
  goto min4;
 min4_return_0:
  x_46X = min40_return_value;
  r_33X->left = x_46X;
  v_47X = TO_INTEGER(x2_27X);
  v_48X = TO_INTEGER(x4_31X);
  v_49X = TO_INTEGER(x1_25X);
  v_50X = TO_INTEGER(x3_29X);
  merged_arg0K0 = v_49X;
  merged_arg0K1 = v_47X;
  merged_arg0K2 = v_50X;
  merged_arg0K3 = v_48X;
  max4_return_tag = 0;
  goto max4;
 max4_return_0:
  x_51X = max40_return_value;
  r_33X->right = x_51X;
  v_52X = TO_INTEGER(y2_28X);
  v_53X = TO_INTEGER(y4_32X);
  v_54X = TO_INTEGER(y1_26X);
  v_55X = TO_INTEGER(y3_30X);
  merged_arg0K0 = v_54X;
  merged_arg0K1 = v_52X;
  merged_arg0K2 = v_55X;
  merged_arg0K3 = v_53X;
  min4_return_tag = 1;
  goto min4;
 min4_return_1:
  x_56X = min40_return_value;
  r_33X->top = x_56X;
  v_57X = TO_INTEGER(y2_28X);
  v_58X = TO_INTEGER(y4_32X);
  v_59X = TO_INTEGER(y1_26X);
  v_60X = TO_INTEGER(y3_30X);
  merged_arg0K0 = v_59X;
  merged_arg0K1 = v_57X;
  merged_arg0K2 = v_60X;
  merged_arg0K3 = v_58X;
  max4_return_tag = 1;
  goto max4;
 max4_return_1:
  x_61X = max40_return_value;
  r_33X->bottom = x_61X;
  return r_33X;}
 min4: {
  a_38X = merged_arg0K0;
  b_39X = merged_arg0K1;
  c_40X = merged_arg0K2;
  d_41X = merged_arg0K3;{
  if ((a_38X < b_39X)) {
    arg0K0 = a_38X;
    goto L705;}
  else {
    arg0K0 = b_39X;
    goto L705;}}
 L705: {
  x_62X = arg0K0;
  if ((x_62X < c_40X)) {
    arg0K0 = x_62X;
    goto L707;}
  else {
    arg0K0 = c_40X;
    goto L707;}}
 L707: {
  x_63X = arg0K0;
  if ((x_63X < d_41X)) {
    min40_return_value = x_63X;
    goto min4_return;}
  else {
    min40_return_value = d_41X;
    goto min4_return;}}
 min4_return:
  switch (min4_return_tag) {
  case 0: goto min4_return_0;
  default: goto min4_return_1;
  }}

 max4: {
  a_34X = merged_arg0K0;
  b_35X = merged_arg0K1;
  c_36X = merged_arg0K2;
  d_37X = merged_arg0K3;{
  if ((a_34X < b_35X)) {
    arg0K0 = b_35X;
    goto L676;}
  else {
    arg0K0 = a_34X;
    goto L676;}}
 L676: {
  x_64X = arg0K0;
  if ((x_64X < c_36X)) {
    arg0K0 = c_36X;
    goto L678;}
  else {
    arg0K0 = x_64X;
    goto L678;}}
 L678: {
  x_65X = arg0K0;
  if ((x_65X < d_37X)) {
    max40_return_value = d_37X;
    goto max4_return;}
  else {
    max40_return_value = x_65X;
    goto max4_return;}}
 max4_return:
  switch (max4_return_tag) {
  case 0: goto max4_return_0;
  default: goto max4_return_1;
  }}

}
static char pt_in_rect(long x_66X, long y_67X, struct rect *rect_68X)
{

 {  if ((x_66X < (rect_68X->left))) {
    return 0;}
  else {
    if ((x_66X < (rect_68X->right))) {
      if ((y_67X < (rect_68X->top))) {
        return 0;}
      else {
        return (y_67X < (rect_68X->bottom));}}
    else {
      return 0;}}}
}
void rect_intersectB(struct rect *r1_69X, struct rect *r2_70X, struct rect *r3_71X)
{
  long arg0K0;
  long b_83X;
  long y_82X;
  long x_81X;
  long l_80X;
  long v_79X;
  long v_78X;
  long t_77X;
  long v_76X;
  long v_75X;
  long r_74X;
  long y_73X;
  long x_72X;
 {  x_72X = r2_70X->right;
  y_73X = r1_69X->right;
  if ((y_73X < x_72X)) {
    arg0K0 = (r1_69X->right);
    goto L803;}
  else {
    if (((r2_70X->right) < (r1_69X->left))) {
      arg0K0 = (r1_69X->left);
      goto L803;}
    else {
      arg0K0 = (r2_70X->right);
      goto L803;}}}
 L803: {
  r_74X = arg0K0;
  v_75X = r2_70X->top;
  v_76X = r1_69X->top;
  if ((v_75X < v_76X)) {
    arg0K0 = (r1_69X->top);
    goto L779;}
  else {
    if (((r1_69X->bottom) < (r2_70X->top))) {
      arg0K0 = (r1_69X->bottom);
      goto L779;}
    else {
      arg0K0 = (r2_70X->top);
      goto L779;}}}
 L779: {
  t_77X = arg0K0;
  v_78X = r2_70X->left;
  v_79X = r1_69X->left;
  if ((v_78X < v_79X)) {
    arg0K0 = (r1_69X->left);
    goto L755;}
  else {
    if (((r1_69X->right) < (r2_70X->left))) {
      arg0K0 = (r1_69X->right);
      goto L755;}
    else {
      arg0K0 = (r2_70X->left);
      goto L755;}}}
 L755: {
  l_80X = arg0K0;
  x_81X = r2_70X->bottom;
  y_82X = r1_69X->bottom;
  if ((y_82X < x_81X)) {
    arg0K0 = (r1_69X->bottom);
    goto L827;}
  else {
    if (((r2_70X->bottom) < (r1_69X->top))) {
      arg0K0 = (r1_69X->top);
      goto L827;}
    else {
      arg0K0 = (r2_70X->bottom);
      goto L827;}}}
 L827: {
  b_83X = arg0K0;
  r3_71X->left = l_80X;
  r3_71X->top = t_77X;
  r3_71X->right = r_74X;
  r3_71X->bottom = b_83X;
  return;}
}
void xfer_rectB(char * addr1_84X, long dx_85X, long dy_86X, long sl1_87X, char * addr2_88X, long sx_89X, long sy_90X, long ex_91X, long ey_92X, long sl2_93X, long bpp_94X)
{
  long arg0K0;
  long off1_111X;
  long i_110X;
  long off1_109X;
  long i_108X;
  long off1_107X;
  long i_106X;
  char * addr2_105X;
  char * addr1_104X;
  long i_103X;
  long i_102X;
  char * addr2_101X;
  char * addr1_100X;
  long i_99X;
  char * addr2_98X;
  char * addr1_97X;
  long i_96X;
  long i_95X;
 {  if ((bpp_94X == 8)) {
    arg0K0 = sy_90X;
    goto L1288;}
  else {
    if ((bpp_94X == 15)) {
      goto L1303;}
    else {
      if ((bpp_94X == 16)) {
        goto L1303;}
      else {
        if ((bpp_94X == 24)) {
          arg0K0 = sy_90X;
          goto L1344;}
        else {
          arg0K0 = sy_90X;
          goto L1368;}}}}}
 L1288: {
  i_95X = arg0K0;
  if ((i_95X < ey_92X)) {
    arg0K0 = sx_89X;
    goto L1389;}
  else {
    return;}}
 L1303: {
  arg0K0 = sy_90X;
  goto L1319;}
 L1344: {
  i_96X = arg0K0;
  if ((i_96X < ey_92X)) {
    addr1_97X = addr1_84X + (sl1_87X * (dy_86X + (i_96X - sy_90X)));
    addr2_98X = addr2_88X + (sl2_93X * i_96X);
    arg0K0 = sx_89X;
    goto L1427;}
  else {
    return;}}
 L1368: {
  i_99X = arg0K0;
  if ((i_99X < ey_92X)) {
    addr1_100X = addr1_84X + (sl1_87X * (dy_86X + (i_99X - sy_90X)));
    addr2_101X = addr2_88X + (sl2_93X * i_99X);
    arg0K0 = sx_89X;
    goto L1450;}
  else {
    return;}}
 L1389: {
  i_102X = arg0K0;
  if ((i_102X < ex_91X)) {
    *((unsigned char *) (addr1_84X + ((sl1_87X * (dy_86X + (i_95X - sy_90X))) + (dx_85X + (i_102X - sx_89X))))) = (unsigned char) ((*((unsigned char *) (addr2_88X + ((sl2_93X * i_95X) + i_102X)))));
    arg0K0 = (1 + i_102X);
    goto L1389;}
  else {
    arg0K0 = (1 + i_95X);
    goto L1288;}}
 L1319: {
  i_103X = arg0K0;
  if ((i_103X < ey_92X)) {
    addr1_104X = addr1_84X + (sl1_87X * (dy_86X + (i_103X - sy_90X)));
    addr2_105X = addr2_88X + (sl2_93X * i_103X);
    arg0K0 = sx_89X;
    goto L1406;}
  else {
    return;}}
 L1427: {
  i_106X = arg0K0;
  if ((i_106X < ex_91X)) {
    off1_107X = dx_85X + (i_106X - sx_89X);
    *((unsigned char *) (addr1_97X + (3 * off1_107X))) = (unsigned char) ((*((unsigned char *) (addr2_98X + (3 * i_106X)))));
    *((unsigned char *) (addr1_97X + (1 + (3 * off1_107X)))) = (unsigned char) ((*((unsigned char *) (addr2_98X + (1 + (3 * i_106X))))));
    *((unsigned char *) (addr1_97X + (2 + (3 * off1_107X)))) = (unsigned char) ((*((unsigned char *) (addr2_98X + (2 + (3 * i_106X))))));
    arg0K0 = (1 + i_106X);
    goto L1427;}
  else {
    arg0K0 = (1 + i_96X);
    goto L1344;}}
 L1450: {
  i_108X = arg0K0;
  if ((i_108X < ex_91X)) {
    off1_109X = dx_85X + (i_108X - sx_89X);
    *((unsigned char *) (addr1_100X + (((off1_109X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_101X + (((i_108X)<<2))))));
    *((unsigned char *) (addr1_100X + (1 + (((off1_109X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_101X + (1 + (((i_108X)<<2)))))));
    *((unsigned char *) (addr1_100X + (2 + (((off1_109X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_101X + (2 + (((i_108X)<<2)))))));
    *((unsigned char *) (addr1_100X + (3 + (((off1_109X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_101X + (3 + (((i_108X)<<2)))))));
    arg0K0 = (1 + i_108X);
    goto L1450;}
  else {
    arg0K0 = (1 + i_99X);
    goto L1368;}}
 L1406: {
  i_110X = arg0K0;
  if ((i_110X < ex_91X)) {
    off1_111X = dx_85X + (i_110X - sx_89X);
    *((unsigned char *) (addr1_104X + (((off1_111X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_105X + (((i_110X)<<1))))));
    *((unsigned char *) (addr1_104X + (1 + (((off1_111X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_105X + (1 + (((i_110X)<<1)))))));
    arg0K0 = (1 + i_110X);
    goto L1406;}
  else {
    arg0K0 = (1 + i_103X);
    goto L1319;}}
}
struct rect *bound_xform_rectB(double *mat_112X, struct rect *r_113X)
{
  struct rect *r_122X;
  double y4_121X;
  double x4_120X;
  double y3_119X;
  double x3_118X;
  double y2_117X;
  double x2_116X;
  double y1_115X;
  double x1_114X;
 {  x1_114X = xform_rect(mat_112X, r_113X, &y1_115X, &x2_116X, &y2_117X, &x3_118X, &y3_119X, &x4_120X, &y4_121X, &r_122X);
  return bound_quadB(x1_114X, y1_115X, x2_116X, y2_117X, x3_118X, y3_119X, x4_120X, y4_121X, r_122X);}
}
void xfer_keyed_rectB(char * addr1_123X, long dx_124X, long dy_125X, long sl1_126X, char * addr2_127X, long sx_128X, long sy_129X, long ex_130X, long ey_131X, long sl2_132X, char * key_133X, long bpp_134X)
{
  long arg0K0;
  long off1_152X;
  long i_151X;
  long off1_150X;
  long i_149X;
  long off1_148X;
  long i_147X;
  char * addr2_146X;
  char * addr1_145X;
  long i_144X;
  long i_143X;
  char * addr2_142X;
  char * addr1_141X;
  long i_140X;
  char * addr2_139X;
  char * addr1_138X;
  long i_137X;
  char * addr2_136X;
  long i_135X;
 {  if ((bpp_134X == 8)) {
    arg0K0 = sy_129X;
    goto L1900;}
  else {
    if ((bpp_134X == 15)) {
      goto L1915;}
    else {
      if ((bpp_134X == 16)) {
        goto L1915;}
      else {
        if ((bpp_134X == 24)) {
          arg0K0 = sy_129X;
          goto L1958;}
        else {
          arg0K0 = sy_129X;
          goto L1983;}}}}}
 L1900: {
  i_135X = arg0K0;
  if ((i_135X < ey_131X)) {
    addr2_136X = addr2_127X + (sl2_132X * i_135X);
    arg0K0 = sx_128X;
    goto L2005;}
  else {
    return;}}
 L1915: {
  arg0K0 = sy_129X;
  goto L1932;}
 L1958: {
  i_137X = arg0K0;
  if ((i_137X < ey_131X)) {
    addr1_138X = addr1_123X + (sl1_126X * (dy_125X + (i_137X - sy_129X)));
    addr2_139X = addr2_127X + (sl2_132X * i_137X);
    arg0K0 = sx_128X;
    goto L2059;}
  else {
    return;}}
 L1983: {
  i_140X = arg0K0;
  if ((i_140X < ey_131X)) {
    addr1_141X = addr1_123X + (sl1_126X * (dy_125X + (i_140X - sy_129X)));
    addr2_142X = addr2_127X + (sl2_132X * i_140X);
    arg0K0 = sx_128X;
    goto L2094;}
  else {
    return;}}
 L2005: {
  i_143X = arg0K0;
  if ((i_143X < ex_130X)) {
    if (((*((unsigned char *) (addr2_136X + i_143X))) == (*((unsigned char *) key_133X)))) {
      goto L2008;}
    else {
      *((unsigned char *) (addr1_123X + ((sl1_126X * (dy_125X + (i_135X - sy_129X))) + (dx_124X + (i_143X - sx_128X))))) = (unsigned char) ((*((unsigned char *) (addr2_136X + i_143X))));
      goto L2008;}}
  else {
    arg0K0 = (1 + i_135X);
    goto L1900;}}
 L1932: {
  i_144X = arg0K0;
  if ((i_144X < ey_131X)) {
    addr1_145X = addr1_123X + (sl1_126X * (dy_125X + (i_144X - sy_129X)));
    addr2_146X = addr2_127X + (sl2_132X * i_144X);
    arg0K0 = sx_128X;
    goto L2028;}
  else {
    return;}}
 L2059: {
  i_147X = arg0K0;
  if ((i_147X < ex_130X)) {
    off1_148X = dx_124X + (i_147X - sx_128X);
    if (((*((unsigned char *) (addr2_139X + (3 * i_147X)))) == (*((unsigned char *) key_133X)))) {
      if (((*((unsigned char *) (addr2_139X + (1 + (3 * i_147X))))) == (*((unsigned char *) (key_133X + 1))))) {
        if (((*((unsigned char *) (addr2_139X + (2 + (3 * i_147X))))) == (*((unsigned char *) (key_133X + 2))))) {
          goto L2062;}
        else {
          goto L2066;}}
      else {
        goto L2066;}}
    else {
      goto L2066;}}
  else {
    arg0K0 = (1 + i_137X);
    goto L1958;}}
 L2094: {
  i_149X = arg0K0;
  if ((i_149X < ex_130X)) {
    off1_150X = dx_124X + (i_149X - sx_128X);
    if (((*((unsigned char *) (addr2_142X + (((i_149X)<<2))))) == (*((unsigned char *) key_133X)))) {
      if (((*((unsigned char *) (addr2_142X + (1 + (((i_149X)<<2)))))) == (*((unsigned char *) (key_133X + 1))))) {
        if (((*((unsigned char *) (addr2_142X + (2 + (((i_149X)<<2)))))) == (*((unsigned char *) (key_133X + 2))))) {
          if (((*((unsigned char *) (addr2_142X + (3 + (((i_149X)<<2)))))) == (*((unsigned char *) (key_133X + 3))))) {
            goto L2097;}
          else {
            goto L2101;}}
        else {
          goto L2101;}}
      else {
        goto L2101;}}
    else {
      goto L2101;}}
  else {
    arg0K0 = (1 + i_140X);
    goto L1983;}}
 L2008: {
  arg0K0 = (1 + i_143X);
  goto L2005;}
 L2028: {
  i_151X = arg0K0;
  if ((i_151X < ex_130X)) {
    off1_152X = dx_124X + (i_151X - sx_128X);
    if (((*((unsigned char *) (addr2_146X + (((i_151X)<<1))))) == (*((unsigned char *) key_133X)))) {
      if (((*((unsigned char *) (addr2_146X + (1 + (((i_151X)<<1)))))) == (*((unsigned char *) (key_133X + 1))))) {
        goto L2031;}
      else {
        goto L2035;}}
    else {
      goto L2035;}}
  else {
    arg0K0 = (1 + i_144X);
    goto L1932;}}
 L2062: {
  arg0K0 = (1 + i_147X);
  goto L2059;}
 L2066: {
  *((unsigned char *) (addr1_138X + (3 * off1_148X))) = (unsigned char) ((*((unsigned char *) (addr2_139X + (3 * i_147X)))));
  *((unsigned char *) (addr1_138X + (1 + (3 * off1_148X)))) = (unsigned char) ((*((unsigned char *) (addr2_139X + (1 + (3 * i_147X))))));
  *((unsigned char *) (addr1_138X + (2 + (3 * off1_148X)))) = (unsigned char) ((*((unsigned char *) (addr2_139X + (2 + (3 * i_147X))))));
  goto L2062;}
 L2097: {
  arg0K0 = (1 + i_149X);
  goto L2094;}
 L2101: {
  *((unsigned char *) (addr1_141X + (((off1_150X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_142X + (((i_149X)<<2))))));
  *((unsigned char *) (addr1_141X + (1 + (((off1_150X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_142X + (1 + (((i_149X)<<2)))))));
  *((unsigned char *) (addr1_141X + (2 + (((off1_150X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_142X + (2 + (((i_149X)<<2)))))));
  *((unsigned char *) (addr1_141X + (3 + (((off1_150X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_142X + (3 + (((i_149X)<<2)))))));
  goto L2097;}
 L2031: {
  arg0K0 = (1 + i_151X);
  goto L2028;}
 L2035: {
  *((unsigned char *) (addr1_145X + (((off1_152X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_146X + (((i_151X)<<1))))));
  *((unsigned char *) (addr1_145X + (1 + (((off1_152X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_146X + (1 + (((i_151X)<<1)))))));
  goto L2031;}
}
void xfer_xformed_rectB(char * addr1_153X, long sl1_154X, char * addr2_155X, long sx_156X, long sy_157X, long ex_158X, long ey_159X, long sl2_160X, double *mat_161X, struct rect *r_162X, long bpp_163X)
{
  double arg1K0;
  char * addr2_182X;
  char * addr1_181X;
  long v_180X;
  long off2_179X;
  char v_178X;
  long v_177X;
  long u_176X;
  double i_175X;
  double j_174X;
  double incy_173X;
  double incx_172X;
  double scly_171X;
  double x_170X;
  double sclx_169X;
  double x_168X;
  double fex_167X;
  double fsx_166X;
  double fey_165X;
  double fsy_164X;
 {  fsy_164X = TO_FLOAT(sy_157X);
  fey_165X = TO_FLOAT(ey_159X);
  fsx_166X = TO_FLOAT(sx_156X);
  fex_167X = TO_FLOAT(ex_158X);
  x_168X = *(mat_161X + 0);
  if ((x_168X < 0.0)) {
    arg1K0 = (0.0 - x_168X);
    goto L2178;}
  else {
    arg1K0 = x_168X;
    goto L2178;}}
 L2178: {
  sclx_169X = arg1K0;
  x_170X = *(mat_161X + 4);
  if ((x_170X < 0.0)) {
    arg1K0 = (0.0 - x_170X);
    goto L2182;}
  else {
    arg1K0 = x_170X;
    goto L2182;}}
 L2182: {
  scly_171X = arg1K0;
  if ((sclx_169X < 1.0)) {
    arg1K0 = 0.5;
    goto L2190;}
  else {
    arg1K0 = (0.5 / sclx_169X);
    goto L2190;}}
 L2190: {
  incx_172X = arg1K0;
  if ((scly_171X < 1.0)) {
    arg1K0 = 0.5;
    goto L2198;}
  else {
    arg1K0 = (0.5 / scly_171X);
    goto L2198;}}
 L2198: {
  incy_173X = arg1K0;
  arg1K0 = fsy_164X;
  goto L2204;}
 L2204: {
  j_174X = arg1K0;
  if ((j_174X < fey_165X)) {
    arg1K0 = fsx_166X;
    goto L2209;}
  else {
    return;}}
 L2209: {
  i_175X = arg1K0;
  if ((i_175X < fex_167X)) {
    u_176X = TO_INTEGER(((((*(mat_161X + 0)) * i_175X) + ((*(mat_161X + 1)) * j_174X)) + (*(mat_161X + 2))));
    v_177X = TO_INTEGER(((((*(mat_161X + 3)) * i_175X) + ((*(mat_161X + 4)) * j_174X)) + (*(mat_161X + 5))));
    v_178X = pt_in_rect(u_176X, v_177X, r_162X);
    if (v_178X) {
      off2_179X = TO_INTEGER(i_175X);
      v_180X = TO_INTEGER(j_174X);
      addr1_181X = addr1_153X + (v_177X * sl1_154X);
      addr2_182X = addr2_155X + (v_180X * sl2_160X);
      if ((8 == bpp_163X)) {
        *((unsigned char *) (addr1_181X + u_176X)) = (unsigned char) ((*((unsigned char *) (addr2_182X + off2_179X))));
        goto L2235;}
      else {
        if ((15 == bpp_163X)) {
          *((unsigned char *) (addr1_181X + (((u_176X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (((off2_179X)<<1))))));
          *((unsigned char *) (addr1_181X + (1 + (((u_176X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (1 + (((off2_179X)<<1)))))));
          goto L2235;}
        else {
          if ((16 == bpp_163X)) {
            *((unsigned char *) (addr1_181X + (((u_176X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (((off2_179X)<<1))))));
            *((unsigned char *) (addr1_181X + (1 + (((u_176X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (1 + (((off2_179X)<<1)))))));
            goto L2235;}
          else {
            if ((24 == bpp_163X)) {
              *((unsigned char *) (addr1_181X + (3 * u_176X))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (3 * off2_179X)))));
              *((unsigned char *) (addr1_181X + (1 + (3 * u_176X)))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (1 + (3 * off2_179X))))));
              *((unsigned char *) (addr1_181X + (2 + (3 * u_176X)))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (2 + (3 * off2_179X))))));
              goto L2235;}
            else {
              if ((32 == bpp_163X)) {
                *((unsigned char *) (addr1_181X + (((u_176X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (((off2_179X)<<2))))));
                *((unsigned char *) (addr1_181X + (1 + (((u_176X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (1 + (((off2_179X)<<2)))))));
                *((unsigned char *) (addr1_181X + (2 + (((u_176X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (2 + (((off2_179X)<<2)))))));
                *((unsigned char *) (addr1_181X + (3 + (((u_176X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_182X + (3 + (((off2_179X)<<2)))))));
                goto L2235;}
              else {
                goto L2235;}}}}}}
    else {
      goto L2235;}}
  else {
    arg1K0 = (j_174X + incy_173X);
    goto L2204;}}
 L2235: {
  arg1K0 = (i_175X + incx_172X);
  goto L2209;}
}
void xfer_xformed_keyed_rectB(char * addr1_183X, long sl1_184X, char * addr2_185X, long sx_186X, long sy_187X, long ex_188X, long ey_189X, long sl2_190X, double *mat_191X, struct rect *r_192X, char * key_193X, long bpp_194X)
{
  double arg1K0;
  char * addr2_269X;
  char * addr1_268X;
  long v_267X;
  long off2_266X;
  char v_265X;
  long v_264X;
  long u_263X;
  double i_262X;
  char * addr2_261X;
  char * addr1_260X;
  long v_259X;
  long off2_258X;
  char v_257X;
  long v_256X;
  long u_255X;
  double i_254X;
  char * addr2_253X;
  char * addr1_252X;
  long v_251X;
  long off2_250X;
  char v_249X;
  long v_248X;
  long u_247X;
  double i_246X;
  double j_245X;
  char * addr2_244X;
  long v_243X;
  long off2_242X;
  char v_241X;
  long v_240X;
  long u_239X;
  double i_238X;
  double j_237X;
  double j_236X;
  double incy_235X;
  double j_234X;
  double incy_233X;
  double incy_232X;
  double incx_231X;
  double incy_230X;
  double incx_229X;
  double incx_228X;
  double scly_227X;
  double incx_226X;
  double scly_225X;
  double scly_224X;
  double x_223X;
  double sclx_222X;
  double scly_221X;
  double x_220X;
  double sclx_219X;
  double x_218X;
  double sclx_217X;
  double x_216X;
  double fex_215X;
  double fsx_214X;
  double fey_213X;
  double fsy_212X;
  double x_211X;
  double sclx_210X;
  double x_209X;
  double fex_208X;
  double fsx_207X;
  double fey_206X;
  double fsy_205X;
  double x_204X;
  double fex_203X;
  double fsx_202X;
  double fey_201X;
  double fsy_200X;
  double x_199X;
  double fex_198X;
  double fsx_197X;
  double fey_196X;
  double fsy_195X;
 {  if ((bpp_194X == 8)) {
    fsy_195X = TO_FLOAT(sy_187X);
    fey_196X = TO_FLOAT(ey_189X);
    fsx_197X = TO_FLOAT(sx_186X);
    fex_198X = TO_FLOAT(ex_188X);
    x_199X = *(mat_191X + 0);
    if ((x_199X < 0.0)) {
      arg1K0 = (0.0 - x_199X);
      goto L2393;}
    else {
      arg1K0 = x_199X;
      goto L2393;}}
  else {
    if ((bpp_194X == 15)) {
      goto L2468;}
    else {
      if ((bpp_194X == 16)) {
        goto L2468;}
      else {
        if ((bpp_194X == 24)) {
          fsy_200X = TO_FLOAT(sy_187X);
          fey_201X = TO_FLOAT(ey_189X);
          fsx_202X = TO_FLOAT(sx_186X);
          fex_203X = TO_FLOAT(ex_188X);
          x_204X = *(mat_191X + 0);
          if ((x_204X < 0.0)) {
            arg1K0 = (0.0 - x_204X);
            goto L2599;}
          else {
            arg1K0 = x_204X;
            goto L2599;}}
        else {
          fsy_205X = TO_FLOAT(sy_187X);
          fey_206X = TO_FLOAT(ey_189X);
          fsx_207X = TO_FLOAT(sx_186X);
          fex_208X = TO_FLOAT(ex_188X);
          x_209X = *(mat_191X + 0);
          if ((x_209X < 0.0)) {
            arg1K0 = (0.0 - x_209X);
            goto L2698;}
          else {
            arg1K0 = x_209X;
            goto L2698;}}}}}}
 L2393: {
  sclx_210X = arg1K0;
  x_211X = *(mat_191X + 4);
  if ((x_211X < 0.0)) {
    arg1K0 = (0.0 - x_211X);
    goto L2397;}
  else {
    arg1K0 = x_211X;
    goto L2397;}}
 L2468: {
  fsy_212X = TO_FLOAT(sy_187X);
  fey_213X = TO_FLOAT(ey_189X);
  fsx_214X = TO_FLOAT(sx_186X);
  fex_215X = TO_FLOAT(ex_188X);
  x_216X = *(mat_191X + 0);
  if ((x_216X < 0.0)) {
    arg1K0 = (0.0 - x_216X);
    goto L2499;}
  else {
    arg1K0 = x_216X;
    goto L2499;}}
 L2599: {
  sclx_217X = arg1K0;
  x_218X = *(mat_191X + 4);
  if ((x_218X < 0.0)) {
    arg1K0 = (0.0 - x_218X);
    goto L2603;}
  else {
    arg1K0 = x_218X;
    goto L2603;}}
 L2698: {
  sclx_219X = arg1K0;
  x_220X = *(mat_191X + 4);
  if ((x_220X < 0.0)) {
    arg1K0 = (0.0 - x_220X);
    goto L2702;}
  else {
    arg1K0 = x_220X;
    goto L2702;}}
 L2397: {
  scly_221X = arg1K0;
  if ((sclx_210X < 1.0)) {
    arg1K0 = 0.5;
    goto L2405;}
  else {
    arg1K0 = (0.5 / sclx_210X);
    goto L2405;}}
 L2499: {
  sclx_222X = arg1K0;
  x_223X = *(mat_191X + 4);
  if ((x_223X < 0.0)) {
    arg1K0 = (0.0 - x_223X);
    goto L2503;}
  else {
    arg1K0 = x_223X;
    goto L2503;}}
 L2603: {
  scly_224X = arg1K0;
  if ((sclx_217X < 1.0)) {
    arg1K0 = 0.5;
    goto L2611;}
  else {
    arg1K0 = (0.5 / sclx_217X);
    goto L2611;}}
 L2702: {
  scly_225X = arg1K0;
  if ((sclx_219X < 1.0)) {
    arg1K0 = 0.5;
    goto L2710;}
  else {
    arg1K0 = (0.5 / sclx_219X);
    goto L2710;}}
 L2405: {
  incx_226X = arg1K0;
  if ((scly_221X < 1.0)) {
    arg1K0 = 0.5;
    goto L2413;}
  else {
    arg1K0 = (0.5 / scly_221X);
    goto L2413;}}
 L2503: {
  scly_227X = arg1K0;
  if ((sclx_222X < 1.0)) {
    arg1K0 = 0.5;
    goto L2511;}
  else {
    arg1K0 = (0.5 / sclx_222X);
    goto L2511;}}
 L2611: {
  incx_228X = arg1K0;
  if ((scly_224X < 1.0)) {
    arg1K0 = 0.5;
    goto L2619;}
  else {
    arg1K0 = (0.5 / scly_224X);
    goto L2619;}}
 L2710: {
  incx_229X = arg1K0;
  if ((scly_225X < 1.0)) {
    arg1K0 = 0.5;
    goto L2718;}
  else {
    arg1K0 = (0.5 / scly_225X);
    goto L2718;}}
 L2413: {
  incy_230X = arg1K0;
  arg1K0 = fsy_195X;
  goto L2419;}
 L2511: {
  incx_231X = arg1K0;
  if ((scly_227X < 1.0)) {
    arg1K0 = 0.5;
    goto L2519;}
  else {
    arg1K0 = (0.5 / scly_227X);
    goto L2519;}}
 L2619: {
  incy_232X = arg1K0;
  arg1K0 = fsy_200X;
  goto L2625;}
 L2718: {
  incy_233X = arg1K0;
  arg1K0 = fsy_205X;
  goto L2724;}
 L2419: {
  j_234X = arg1K0;
  if ((j_234X < fey_196X)) {
    arg1K0 = fsx_197X;
    goto L2424;}
  else {
    return;}}
 L2519: {
  incy_235X = arg1K0;
  arg1K0 = fsy_212X;
  goto L2525;}
 L2625: {
  j_236X = arg1K0;
  if ((j_236X < fey_201X)) {
    arg1K0 = fsx_202X;
    goto L2630;}
  else {
    return;}}
 L2724: {
  j_237X = arg1K0;
  if ((j_237X < fey_206X)) {
    arg1K0 = fsx_207X;
    goto L2729;}
  else {
    return;}}
 L2424: {
  i_238X = arg1K0;
  if ((i_238X < fex_198X)) {
    u_239X = TO_INTEGER(((((*(mat_191X + 0)) * i_238X) + ((*(mat_191X + 1)) * j_234X)) + (*(mat_191X + 2))));
    v_240X = TO_INTEGER(((((*(mat_191X + 3)) * i_238X) + ((*(mat_191X + 4)) * j_234X)) + (*(mat_191X + 5))));
    v_241X = pt_in_rect(u_239X, v_240X, r_192X);
    if (v_241X) {
      off2_242X = TO_INTEGER(i_238X);
      v_243X = TO_INTEGER(j_234X);
      addr2_244X = addr2_185X + (v_243X * sl2_190X);
      if (((*((unsigned char *) (addr2_244X + off2_242X))) == (*((unsigned char *) key_193X)))) {
        goto L2450;}
      else {
        *((unsigned char *) (addr1_183X + ((v_240X * sl1_184X) + u_239X))) = (unsigned char) ((*((unsigned char *) (addr2_244X + off2_242X))));
        goto L2450;}}
    else {
      goto L2450;}}
  else {
    arg1K0 = (j_234X + incy_230X);
    goto L2419;}}
 L2525: {
  j_245X = arg1K0;
  if ((j_245X < fey_213X)) {
    arg1K0 = fsx_214X;
    goto L2530;}
  else {
    return;}}
 L2630: {
  i_246X = arg1K0;
  if ((i_246X < fex_203X)) {
    u_247X = TO_INTEGER(((((*(mat_191X + 0)) * i_246X) + ((*(mat_191X + 1)) * j_236X)) + (*(mat_191X + 2))));
    v_248X = TO_INTEGER(((((*(mat_191X + 3)) * i_246X) + ((*(mat_191X + 4)) * j_236X)) + (*(mat_191X + 5))));
    v_249X = pt_in_rect(u_247X, v_248X, r_192X);
    if (v_249X) {
      off2_250X = TO_INTEGER(i_246X);
      v_251X = TO_INTEGER(j_236X);
      addr1_252X = addr1_183X + (v_248X * sl1_184X);
      addr2_253X = addr2_185X + (v_251X * sl2_190X);
      if (((*((unsigned char *) (addr2_253X + (3 * off2_250X)))) == (*((unsigned char *) key_193X)))) {
        if (((*((unsigned char *) (addr2_253X + (1 + (3 * off2_250X))))) == (*((unsigned char *) (key_193X + 1))))) {
          if (((*((unsigned char *) (addr2_253X + (2 + (3 * off2_250X))))) == (*((unsigned char *) (key_193X + 2))))) {
            goto L2656;}
          else {
            goto L2880;}}
        else {
          goto L2880;}}
      else {
        goto L2880;}}
    else {
      goto L2656;}}
  else {
    arg1K0 = (j_236X + incy_232X);
    goto L2625;}}
 L2729: {
  i_254X = arg1K0;
  if ((i_254X < fex_208X)) {
    u_255X = TO_INTEGER(((((*(mat_191X + 0)) * i_254X) + ((*(mat_191X + 1)) * j_237X)) + (*(mat_191X + 2))));
    v_256X = TO_INTEGER(((((*(mat_191X + 3)) * i_254X) + ((*(mat_191X + 4)) * j_237X)) + (*(mat_191X + 5))));
    v_257X = pt_in_rect(u_255X, v_256X, r_192X);
    if (v_257X) {
      off2_258X = TO_INTEGER(i_254X);
      v_259X = TO_INTEGER(j_237X);
      addr1_260X = addr1_183X + (v_256X * sl1_184X);
      addr2_261X = addr2_185X + (v_259X * sl2_190X);
      if (((*((unsigned char *) (addr2_261X + (((off2_258X)<<2))))) == (*((unsigned char *) key_193X)))) {
        if (((*((unsigned char *) (addr2_261X + (1 + (((off2_258X)<<2)))))) == (*((unsigned char *) (key_193X + 1))))) {
          if (((*((unsigned char *) (addr2_261X + (2 + (((off2_258X)<<2)))))) == (*((unsigned char *) (key_193X + 2))))) {
            if (((*((unsigned char *) (addr2_261X + (3 + (((off2_258X)<<2)))))) == (*((unsigned char *) (key_193X + 3))))) {
              goto L2755;}
            else {
              goto L2930;}}
          else {
            goto L2930;}}
        else {
          goto L2930;}}
      else {
        goto L2930;}}
    else {
      goto L2755;}}
  else {
    arg1K0 = (j_237X + incy_233X);
    goto L2724;}}
 L2450: {
  arg1K0 = (i_238X + incx_226X);
  goto L2424;}
 L2530: {
  i_262X = arg1K0;
  if ((i_262X < fex_215X)) {
    u_263X = TO_INTEGER(((((*(mat_191X + 0)) * i_262X) + ((*(mat_191X + 1)) * j_245X)) + (*(mat_191X + 2))));
    v_264X = TO_INTEGER(((((*(mat_191X + 3)) * i_262X) + ((*(mat_191X + 4)) * j_245X)) + (*(mat_191X + 5))));
    v_265X = pt_in_rect(u_263X, v_264X, r_192X);
    if (v_265X) {
      off2_266X = TO_INTEGER(i_262X);
      v_267X = TO_INTEGER(j_245X);
      addr1_268X = addr1_183X + (v_264X * sl1_184X);
      addr2_269X = addr2_185X + (v_267X * sl2_190X);
      if (((*((unsigned char *) (addr2_269X + (((off2_266X)<<1))))) == (*((unsigned char *) key_193X)))) {
        if (((*((unsigned char *) (addr2_269X + (1 + (((off2_266X)<<1)))))) == (*((unsigned char *) (key_193X + 1))))) {
          goto L2556;}
        else {
          goto L2834;}}
      else {
        goto L2834;}}
    else {
      goto L2556;}}
  else {
    arg1K0 = (j_245X + incy_235X);
    goto L2525;}}
 L2656: {
  arg1K0 = (i_246X + incx_228X);
  goto L2630;}
 L2880: {
  *((unsigned char *) (addr1_252X + (3 * u_247X))) = (unsigned char) ((*((unsigned char *) (addr2_253X + (3 * off2_250X)))));
  *((unsigned char *) (addr1_252X + (1 + (3 * u_247X)))) = (unsigned char) ((*((unsigned char *) (addr2_253X + (1 + (3 * off2_250X))))));
  *((unsigned char *) (addr1_252X + (2 + (3 * u_247X)))) = (unsigned char) ((*((unsigned char *) (addr2_253X + (2 + (3 * off2_250X))))));
  goto L2656;}
 L2755: {
  arg1K0 = (i_254X + incx_229X);
  goto L2729;}
 L2930: {
  *((unsigned char *) (addr1_260X + (((u_255X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_261X + (((off2_258X)<<2))))));
  *((unsigned char *) (addr1_260X + (1 + (((u_255X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_261X + (1 + (((off2_258X)<<2)))))));
  *((unsigned char *) (addr1_260X + (2 + (((u_255X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_261X + (2 + (((off2_258X)<<2)))))));
  *((unsigned char *) (addr1_260X + (3 + (((u_255X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_261X + (3 + (((off2_258X)<<2)))))));
  goto L2755;}
 L2556: {
  arg1K0 = (i_262X + incx_231X);
  goto L2530;}
 L2834: {
  *((unsigned char *) (addr1_268X + (((u_263X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_269X + (((off2_266X)<<1))))));
  *((unsigned char *) (addr1_268X + (1 + (((u_263X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_269X + (1 + (((off2_266X)<<1)))))));
  goto L2556;}
}
void xform_clipB(double *mat_270X, double *inv_271X, struct rect *src_rect_272X, struct rect *dest_rect_273X, struct rect *scratch1_274X, struct rect *scratch2_275X)
{
  struct rect *r_294X;
  double y4_293X;
  double x4_292X;
  double y3_291X;
  double x3_290X;
  double y2_289X;
  double x2_288X;
  double y1_287X;
  double x1_286X;
  struct rect *r_285X;
  double y4_284X;
  double x4_283X;
  double y3_282X;
  double x3_281X;
  double y2_280X;
  double x2_279X;
  double y1_278X;
  double x1_277X;
  long v_276X;
 {  v_276X = mat_invert3x3(mat_270X, inv_271X);
  if ((0 == v_276X)) {
    scratch1_274X->left = (src_rect_272X->left);
    scratch1_274X->top = (src_rect_272X->top);
    scratch1_274X->right = (src_rect_272X->right);
    scratch1_274X->bottom = (src_rect_272X->bottom);
    x1_277X = xform_rect(mat_270X, src_rect_272X, &y1_278X, &x2_279X, &y2_280X, &x3_281X, &y3_282X, &x4_283X, &y4_284X, &r_285X);bound_quadB(x1_277X, y1_278X, x2_279X, y2_280X, x3_281X, y3_282X, x4_283X, y4_284X, r_285X);rect_intersectB(dest_rect_273X, src_rect_272X, scratch2_275X);
    x1_286X = xform_rect(inv_271X, scratch2_275X, &y1_287X, &x2_288X, &y2_289X, &x3_290X, &y3_291X, &x4_292X, &y4_293X, &r_294X);bound_quadB(x1_286X, y1_287X, x2_288X, y2_289X, x3_290X, y3_291X, x4_292X, y4_293X, r_294X);
    scratch2_275X->right = (1 + (scratch2_275X->right));
    scratch2_275X->bottom = (1 + (scratch2_275X->bottom));
    rect_intersectB(scratch1_274X, scratch2_275X, src_rect_272X);
    return;}
  else {
    return;}}
}

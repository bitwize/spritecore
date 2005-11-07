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
static void rect_intersectB(struct rect*, struct rect*, struct rect*);
static struct rect *bound_quadB(double, double, double, double, double, double, double, double, struct rect*);
static char pt_in_rect(long, long, struct rect*);
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
static void rect_intersectB(struct rect *r1_25X, struct rect *r2_26X, struct rect *r3_27X)
{
  long arg0K0;
  long b_39X;
  long y_38X;
  long x_37X;
  long l_36X;
  long v_35X;
  long v_34X;
  long t_33X;
  long v_32X;
  long v_31X;
  long r_30X;
  long y_29X;
  long x_28X;
 {  x_28X = r2_26X->right;
  y_29X = r1_25X->right;
  if ((y_29X < x_28X)) {
    arg0K0 = (r1_25X->right);
    goto L655;}
  else {
    if (((r2_26X->right) < (r1_25X->left))) {
      arg0K0 = (r1_25X->left);
      goto L655;}
    else {
      arg0K0 = (r2_26X->right);
      goto L655;}}}
 L655: {
  r_30X = arg0K0;
  v_31X = r2_26X->top;
  v_32X = r1_25X->top;
  if ((v_31X < v_32X)) {
    arg0K0 = (r1_25X->top);
    goto L631;}
  else {
    if (((r1_25X->bottom) < (r2_26X->top))) {
      arg0K0 = (r1_25X->bottom);
      goto L631;}
    else {
      arg0K0 = (r2_26X->top);
      goto L631;}}}
 L631: {
  t_33X = arg0K0;
  v_34X = r2_26X->left;
  v_35X = r1_25X->left;
  if ((v_34X < v_35X)) {
    arg0K0 = (r1_25X->left);
    goto L607;}
  else {
    if (((r1_25X->right) < (r2_26X->left))) {
      arg0K0 = (r1_25X->right);
      goto L607;}
    else {
      arg0K0 = (r2_26X->left);
      goto L607;}}}
 L607: {
  l_36X = arg0K0;
  x_37X = r2_26X->bottom;
  y_38X = r1_25X->bottom;
  if ((y_38X < x_37X)) {
    arg0K0 = (r1_25X->bottom);
    goto L679;}
  else {
    if (((r2_26X->bottom) < (r1_25X->top))) {
      arg0K0 = (r1_25X->top);
      goto L679;}
    else {
      arg0K0 = (r2_26X->bottom);
      goto L679;}}}
 L679: {
  b_39X = arg0K0;
  r3_27X->left = l_36X;
  r3_27X->top = t_33X;
  r3_27X->right = r_30X;
  r3_27X->bottom = b_39X;
  return;}
}
static struct rect *bound_quadB(double x1_40X, double y1_41X, double x2_42X, double y2_43X, double x3_44X, double y3_45X, double x4_46X, double y4_47X, struct rect *r_48X)
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
  long a_49X;
  long b_50X;
  long c_51X;
  long d_52X;
  long a_53X;
  long b_54X;
  long c_55X;
  long d_56X;
  long x_80X;
  long x_79X;
  long x_78X;
  long x_77X;
  long x_76X;
  long v_75X;
  long v_74X;
  long v_73X;
  long v_72X;
  long x_71X;
  long v_70X;
  long v_69X;
  long v_68X;
  long v_67X;
  long x_66X;
  long v_65X;
  long v_64X;
  long v_63X;
  long v_62X;
  long x_61X;
  long v_60X;
  long v_59X;
  long v_58X;
  long v_57X;
 {  v_57X = TO_INTEGER(x2_42X);
  v_58X = TO_INTEGER(x4_46X);
  v_59X = TO_INTEGER(x1_40X);
  v_60X = TO_INTEGER(x3_44X);
  merged_arg0K0 = v_59X;
  merged_arg0K1 = v_57X;
  merged_arg0K2 = v_60X;
  merged_arg0K3 = v_58X;
  min4_return_tag = 0;
  goto min4;
 min4_return_0:
  x_61X = min40_return_value;
  r_48X->left = x_61X;
  v_62X = TO_INTEGER(x2_42X);
  v_63X = TO_INTEGER(x4_46X);
  v_64X = TO_INTEGER(x1_40X);
  v_65X = TO_INTEGER(x3_44X);
  merged_arg0K0 = v_64X;
  merged_arg0K1 = v_62X;
  merged_arg0K2 = v_65X;
  merged_arg0K3 = v_63X;
  max4_return_tag = 0;
  goto max4;
 max4_return_0:
  x_66X = max40_return_value;
  r_48X->right = x_66X;
  v_67X = TO_INTEGER(y2_43X);
  v_68X = TO_INTEGER(y4_47X);
  v_69X = TO_INTEGER(y1_41X);
  v_70X = TO_INTEGER(y3_45X);
  merged_arg0K0 = v_69X;
  merged_arg0K1 = v_67X;
  merged_arg0K2 = v_70X;
  merged_arg0K3 = v_68X;
  min4_return_tag = 1;
  goto min4;
 min4_return_1:
  x_71X = min40_return_value;
  r_48X->top = x_71X;
  v_72X = TO_INTEGER(y2_43X);
  v_73X = TO_INTEGER(y4_47X);
  v_74X = TO_INTEGER(y1_41X);
  v_75X = TO_INTEGER(y3_45X);
  merged_arg0K0 = v_74X;
  merged_arg0K1 = v_72X;
  merged_arg0K2 = v_75X;
  merged_arg0K3 = v_73X;
  max4_return_tag = 1;
  goto max4;
 max4_return_1:
  x_76X = max40_return_value;
  r_48X->bottom = x_76X;
  return r_48X;}
 min4: {
  a_53X = merged_arg0K0;
  b_54X = merged_arg0K1;
  c_55X = merged_arg0K2;
  d_56X = merged_arg0K3;{
  if ((a_53X < b_54X)) {
    arg0K0 = a_53X;
    goto L557;}
  else {
    arg0K0 = b_54X;
    goto L557;}}
 L557: {
  x_77X = arg0K0;
  if ((x_77X < c_55X)) {
    arg0K0 = x_77X;
    goto L559;}
  else {
    arg0K0 = c_55X;
    goto L559;}}
 L559: {
  x_78X = arg0K0;
  if ((x_78X < d_56X)) {
    min40_return_value = x_78X;
    goto min4_return;}
  else {
    min40_return_value = d_56X;
    goto min4_return;}}
 min4_return:
  switch (min4_return_tag) {
  case 0: goto min4_return_0;
  default: goto min4_return_1;
  }}

 max4: {
  a_49X = merged_arg0K0;
  b_50X = merged_arg0K1;
  c_51X = merged_arg0K2;
  d_52X = merged_arg0K3;{
  if ((a_49X < b_50X)) {
    arg0K0 = b_50X;
    goto L528;}
  else {
    arg0K0 = a_49X;
    goto L528;}}
 L528: {
  x_79X = arg0K0;
  if ((x_79X < c_51X)) {
    arg0K0 = c_51X;
    goto L530;}
  else {
    arg0K0 = x_79X;
    goto L530;}}
 L530: {
  x_80X = arg0K0;
  if ((x_80X < d_52X)) {
    max40_return_value = d_52X;
    goto max4_return;}
  else {
    max40_return_value = x_80X;
    goto max4_return;}}
 max4_return:
  switch (max4_return_tag) {
  case 0: goto max4_return_0;
  default: goto max4_return_1;
  }}

}
static char pt_in_rect(long x_81X, long y_82X, struct rect *rect_83X)
{

 {  if ((x_81X < (rect_83X->left))) {
    return 0;}
  else {
    if ((x_81X < (rect_83X->right))) {
      if ((y_82X < (rect_83X->top))) {
        return 0;}
      else {
        return (y_82X < (rect_83X->bottom));}}
    else {
      return 0;}}}
}
void xfer_rectB(char * addr1_84X, long dx_85X, long dy_86X, long sl1_87X, char * addr2_88X, long sx_89X, long sy_90X, long ex_91X, long ey_92X, long sl2_93X, long bpp_94X)
{
  long arg0K0;
  long off1_99X;
  long i_98X;
  char * addr2_97X;
  char * addr1_96X;
  long i_95X;
 {  arg0K0 = sy_90X;
  goto L1532;}
 L1532: {
  i_95X = arg0K0;
  if ((i_95X < ey_92X)) {
    addr1_96X = addr1_84X + (sl1_87X * (dy_86X + (i_95X - sy_90X)));
    addr2_97X = addr2_88X + (sl2_93X * i_95X);
    arg0K0 = sx_89X;
    goto L1552;}
  else {
    return;}}
 L1552: {
  i_98X = arg0K0;
  if ((i_98X < ex_91X)) {
    off1_99X = dx_85X + (i_98X - sx_89X);
    if ((8 == bpp_94X)) {
      *((unsigned char *) (addr1_96X + off1_99X)) = (unsigned char) ((*((unsigned char *) (addr2_97X + i_98X))));
      goto L1555;}
    else {
      if ((15 == bpp_94X)) {
        *((unsigned char *) (addr1_96X + (((off1_99X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (((i_98X)<<1))))));
        *((unsigned char *) (addr1_96X + (1 + (((off1_99X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (1 + (((i_98X)<<1)))))));
        goto L1555;}
      else {
        if ((16 == bpp_94X)) {
          *((unsigned char *) (addr1_96X + (((off1_99X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (((i_98X)<<1))))));
          *((unsigned char *) (addr1_96X + (1 + (((off1_99X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (1 + (((i_98X)<<1)))))));
          goto L1555;}
        else {
          if ((24 == bpp_94X)) {
            *((unsigned char *) (addr1_96X + (3 * off1_99X))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (3 * i_98X)))));
            *((unsigned char *) (addr1_96X + (1 + (3 * off1_99X)))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (1 + (3 * i_98X))))));
            *((unsigned char *) (addr1_96X + (2 + (3 * off1_99X)))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (2 + (3 * i_98X))))));
            goto L1555;}
          else {
            if ((32 == bpp_94X)) {
              *((unsigned char *) (addr1_96X + (((off1_99X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (((i_98X)<<2))))));
              *((unsigned char *) (addr1_96X + (1 + (((off1_99X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (1 + (((i_98X)<<2)))))));
              *((unsigned char *) (addr1_96X + (2 + (((off1_99X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (2 + (((i_98X)<<2)))))));
              *((unsigned char *) (addr1_96X + (3 + (((off1_99X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_97X + (3 + (((i_98X)<<2)))))));
              goto L1555;}
            else {
              goto L1555;}}}}}}
  else {
    arg0K0 = (1 + i_95X);
    goto L1532;}}
 L1555: {
  arg0K0 = (1 + i_98X);
  goto L1552;}
}
struct rect *bound_xform_rectB(double *mat_100X, struct rect *r_101X)
{
  struct rect *r_110X;
  double y4_109X;
  double x4_108X;
  double y3_107X;
  double x3_106X;
  double y2_105X;
  double x2_104X;
  double y1_103X;
  double x1_102X;
 {  x1_102X = xform_rect(mat_100X, r_101X, &y1_103X, &x2_104X, &y2_105X, &x3_106X, &y3_107X, &x4_108X, &y4_109X, &r_110X);
  return bound_quadB(x1_102X, y1_103X, x2_104X, y2_105X, x3_106X, y3_107X, x4_108X, y4_109X, r_110X);}
}
void xfer_keyed_rectB(char * addr1_111X, long dx_112X, long dy_113X, long sl1_114X, char * addr2_115X, long sx_116X, long sy_117X, long ex_118X, long ey_119X, long sl2_120X, char * key_121X, long bpp_122X)
{
  long arg0K0;
  long off1_127X;
  long i_126X;
  char * addr2_125X;
  char * addr1_124X;
  long i_123X;
 {  arg0K0 = sy_117X;
  goto L1642;}
 L1642: {
  i_123X = arg0K0;
  if ((i_123X < ey_119X)) {
    addr1_124X = addr1_111X + (sl1_114X * (dy_113X + (i_123X - sy_117X)));
    addr2_125X = addr2_115X + (sl2_120X * i_123X);
    arg0K0 = sx_116X;
    goto L1663;}
  else {
    return;}}
 L1663: {
  i_126X = arg0K0;
  if ((i_126X < ex_118X)) {
    off1_127X = dx_112X + (i_126X - sx_116X);
    if ((8 == bpp_122X)) {
      if (((*((unsigned char *) (addr2_125X + i_126X))) == (*((unsigned char *) key_121X)))) {
        goto L1666;}
      else {
        *((unsigned char *) (addr1_124X + off1_127X)) = (unsigned char) ((*((unsigned char *) (addr2_125X + i_126X))));
        goto L1666;}}
    else {
      if ((15 == bpp_122X)) {
        if (((*((unsigned char *) (addr2_125X + (((i_126X)<<1))))) == (*((unsigned char *) key_121X)))) {
          if (((*((unsigned char *) (addr2_125X + (1 + (((i_126X)<<1)))))) == (*((unsigned char *) (key_121X + 1))))) {
            goto L1666;}
          else {
            goto L1724;}}
        else {
          goto L1724;}}
      else {
        if ((16 == bpp_122X)) {
          if (((*((unsigned char *) (addr2_125X + (((i_126X)<<1))))) == (*((unsigned char *) key_121X)))) {
            if (((*((unsigned char *) (addr2_125X + (1 + (((i_126X)<<1)))))) == (*((unsigned char *) (key_121X + 1))))) {
              goto L1666;}
            else {
              goto L1712;}}
          else {
            goto L1712;}}
        else {
          if ((24 == bpp_122X)) {
            if (((*((unsigned char *) (addr2_125X + (3 * i_126X)))) == (*((unsigned char *) key_121X)))) {
              if (((*((unsigned char *) (addr2_125X + (1 + (3 * i_126X))))) == (*((unsigned char *) (key_121X + 1))))) {
                if (((*((unsigned char *) (addr2_125X + (2 + (3 * i_126X))))) == (*((unsigned char *) (key_121X + 2))))) {
                  goto L1666;}
                else {
                  goto L1696;}}
              else {
                goto L1696;}}
            else {
              goto L1696;}}
          else {
            if ((32 == bpp_122X)) {
              if (((*((unsigned char *) (addr2_125X + (((i_126X)<<2))))) == (*((unsigned char *) key_121X)))) {
                if (((*((unsigned char *) (addr2_125X + (1 + (((i_126X)<<2)))))) == (*((unsigned char *) (key_121X + 1))))) {
                  if (((*((unsigned char *) (addr2_125X + (2 + (((i_126X)<<2)))))) == (*((unsigned char *) (key_121X + 2))))) {
                    if (((*((unsigned char *) (addr2_125X + (3 + (((i_126X)<<2)))))) == (*((unsigned char *) (key_121X + 3))))) {
                      goto L1666;}
                    else {
                      goto L1676;}}
                  else {
                    goto L1676;}}
                else {
                  goto L1676;}}
              else {
                goto L1676;}}
            else {
              goto L1666;}}}}}}
  else {
    arg0K0 = (1 + i_123X);
    goto L1642;}}
 L1666: {
  arg0K0 = (1 + i_126X);
  goto L1663;}
 L1724: {
  *((unsigned char *) (addr1_124X + (((off1_127X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (((i_126X)<<1))))));
  *((unsigned char *) (addr1_124X + (1 + (((off1_127X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (1 + (((i_126X)<<1)))))));
  goto L1666;}
 L1712: {
  *((unsigned char *) (addr1_124X + (((off1_127X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (((i_126X)<<1))))));
  *((unsigned char *) (addr1_124X + (1 + (((off1_127X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (1 + (((i_126X)<<1)))))));
  goto L1666;}
 L1696: {
  *((unsigned char *) (addr1_124X + (3 * off1_127X))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (3 * i_126X)))));
  *((unsigned char *) (addr1_124X + (1 + (3 * off1_127X)))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (1 + (3 * i_126X))))));
  *((unsigned char *) (addr1_124X + (2 + (3 * off1_127X)))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (2 + (3 * i_126X))))));
  goto L1666;}
 L1676: {
  *((unsigned char *) (addr1_124X + (((off1_127X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (((i_126X)<<2))))));
  *((unsigned char *) (addr1_124X + (1 + (((off1_127X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (1 + (((i_126X)<<2)))))));
  *((unsigned char *) (addr1_124X + (2 + (((off1_127X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (2 + (((i_126X)<<2)))))));
  *((unsigned char *) (addr1_124X + (3 + (((off1_127X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_125X + (3 + (((i_126X)<<2)))))));
  goto L1666;}
}
void xfer_xformed_rectB(char * addr1_128X, long sl1_129X, char * addr2_130X, long sx_131X, long sy_132X, long ex_133X, long ey_134X, long sl2_135X, double *mat_136X, struct rect *r_137X, long bpp_138X)
{
  double arg1K0;
  char * addr2_157X;
  char * addr1_156X;
  long v_155X;
  long off2_154X;
  char v_153X;
  long v_152X;
  long u_151X;
  double i_150X;
  double j_149X;
  double incy_148X;
  double incx_147X;
  double scly_146X;
  double x_145X;
  double sclx_144X;
  double x_143X;
  double fex_142X;
  double fsx_141X;
  double fey_140X;
  double fsy_139X;
 {  fsy_139X = TO_FLOAT(sy_132X);
  fey_140X = TO_FLOAT(ey_134X);
  fsx_141X = TO_FLOAT(sx_131X);
  fex_142X = TO_FLOAT(ex_133X);
  x_143X = *(mat_136X + 0);
  if ((x_143X < 0.0)) {
    arg1K0 = (0.0 - x_143X);
    goto L1775;}
  else {
    arg1K0 = x_143X;
    goto L1775;}}
 L1775: {
  sclx_144X = arg1K0;
  x_145X = *(mat_136X + 4);
  if ((x_145X < 0.0)) {
    arg1K0 = (0.0 - x_145X);
    goto L1779;}
  else {
    arg1K0 = x_145X;
    goto L1779;}}
 L1779: {
  scly_146X = arg1K0;
  if ((sclx_144X < 1.0)) {
    arg1K0 = 0.5;
    goto L1787;}
  else {
    arg1K0 = (0.5 / sclx_144X);
    goto L1787;}}
 L1787: {
  incx_147X = arg1K0;
  if ((scly_146X < 1.0)) {
    arg1K0 = 0.5;
    goto L1795;}
  else {
    arg1K0 = (0.5 / scly_146X);
    goto L1795;}}
 L1795: {
  incy_148X = arg1K0;
  arg1K0 = fsy_139X;
  goto L1801;}
 L1801: {
  j_149X = arg1K0;
  if ((j_149X < fey_140X)) {
    arg1K0 = fsx_141X;
    goto L1806;}
  else {
    return;}}
 L1806: {
  i_150X = arg1K0;
  if ((i_150X < fex_142X)) {
    u_151X = TO_INTEGER(((((*(mat_136X + 0)) * i_150X) + ((*(mat_136X + 1)) * j_149X)) + (*(mat_136X + 2))));
    v_152X = TO_INTEGER(((((*(mat_136X + 3)) * i_150X) + ((*(mat_136X + 4)) * j_149X)) + (*(mat_136X + 5))));
    v_153X = pt_in_rect(u_151X, v_152X, r_137X);
    if (v_153X) {
      off2_154X = TO_INTEGER(i_150X);
      v_155X = TO_INTEGER(j_149X);
      addr1_156X = addr1_128X + (v_152X * sl1_129X);
      addr2_157X = addr2_130X + (v_155X * sl2_135X);
      if ((8 == bpp_138X)) {
        *((unsigned char *) (addr1_156X + u_151X)) = (unsigned char) ((*((unsigned char *) (addr2_157X + off2_154X))));
        goto L1832;}
      else {
        if ((15 == bpp_138X)) {
          *((unsigned char *) (addr1_156X + (((u_151X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (((off2_154X)<<1))))));
          *((unsigned char *) (addr1_156X + (1 + (((u_151X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (1 + (((off2_154X)<<1)))))));
          goto L1832;}
        else {
          if ((16 == bpp_138X)) {
            *((unsigned char *) (addr1_156X + (((u_151X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (((off2_154X)<<1))))));
            *((unsigned char *) (addr1_156X + (1 + (((u_151X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (1 + (((off2_154X)<<1)))))));
            goto L1832;}
          else {
            if ((24 == bpp_138X)) {
              *((unsigned char *) (addr1_156X + (3 * u_151X))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (3 * off2_154X)))));
              *((unsigned char *) (addr1_156X + (1 + (3 * u_151X)))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (1 + (3 * off2_154X))))));
              *((unsigned char *) (addr1_156X + (2 + (3 * u_151X)))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (2 + (3 * off2_154X))))));
              goto L1832;}
            else {
              if ((32 == bpp_138X)) {
                *((unsigned char *) (addr1_156X + (((u_151X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (((off2_154X)<<2))))));
                *((unsigned char *) (addr1_156X + (1 + (((u_151X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (1 + (((off2_154X)<<2)))))));
                *((unsigned char *) (addr1_156X + (2 + (((u_151X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (2 + (((off2_154X)<<2)))))));
                *((unsigned char *) (addr1_156X + (3 + (((u_151X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_157X + (3 + (((off2_154X)<<2)))))));
                goto L1832;}
              else {
                goto L1832;}}}}}}
    else {
      goto L1832;}}
  else {
    arg1K0 = (j_149X + incy_148X);
    goto L1801;}}
 L1832: {
  arg1K0 = (i_150X + incx_147X);
  goto L1806;}
}
void xfer_xformed_keyed_rectB(char * addr1_158X, long sl1_159X, char * addr2_160X, long sx_161X, long sy_162X, long ex_163X, long ey_164X, long sl2_165X, double *mat_166X, struct rect *r_167X, char * key_168X, long bpp_169X)
{
  double arg1K0;
  char * addr2_188X;
  char * addr1_187X;
  long off2_186X;
  long v_185X;
  char v_184X;
  long v_183X;
  long u_182X;
  double i_181X;
  double j_180X;
  double incy_179X;
  double incx_178X;
  double scly_177X;
  double x_176X;
  double sclx_175X;
  double x_174X;
  double fex_173X;
  double fsx_172X;
  double fey_171X;
  double fsy_170X;
 {  fsy_170X = TO_FLOAT(sy_162X);
  fey_171X = TO_FLOAT(ey_164X);
  fsx_172X = TO_FLOAT(sx_161X);
  fex_173X = TO_FLOAT(ex_163X);
  x_174X = *(mat_166X + 0);
  if ((x_174X < 0.0)) {
    arg1K0 = (0.0 - x_174X);
    goto L1972;}
  else {
    arg1K0 = x_174X;
    goto L1972;}}
 L1972: {
  sclx_175X = arg1K0;
  x_176X = *(mat_166X + 4);
  if ((x_176X < 0.0)) {
    arg1K0 = (0.0 - x_176X);
    goto L1976;}
  else {
    arg1K0 = x_176X;
    goto L1976;}}
 L1976: {
  scly_177X = arg1K0;
  if ((sclx_175X < 1.0)) {
    arg1K0 = 0.5;
    goto L1984;}
  else {
    arg1K0 = (0.5 / sclx_175X);
    goto L1984;}}
 L1984: {
  incx_178X = arg1K0;
  if ((scly_177X < 1.0)) {
    arg1K0 = 0.5;
    goto L1992;}
  else {
    arg1K0 = (0.5 / scly_177X);
    goto L1992;}}
 L1992: {
  incy_179X = arg1K0;
  arg1K0 = fsy_170X;
  goto L1998;}
 L1998: {
  j_180X = arg1K0;
  if ((j_180X < fey_171X)) {
    arg1K0 = fsx_172X;
    goto L2003;}
  else {
    return;}}
 L2003: {
  i_181X = arg1K0;
  if ((i_181X < fex_173X)) {
    u_182X = TO_INTEGER(((((*(mat_166X + 0)) * i_181X) + ((*(mat_166X + 1)) * j_180X)) + (*(mat_166X + 2))));
    v_183X = TO_INTEGER(((((*(mat_166X + 3)) * i_181X) + ((*(mat_166X + 4)) * j_180X)) + (*(mat_166X + 5))));
    v_184X = pt_in_rect(u_182X, v_183X, r_167X);
    if (v_184X) {
      v_185X = TO_INTEGER(j_180X);
      off2_186X = TO_INTEGER(i_181X);
      addr1_187X = addr1_158X + (v_183X * sl1_159X);
      addr2_188X = addr2_160X + (v_185X * sl2_165X);
      if ((8 == bpp_169X)) {
        if (((*((unsigned char *) (addr2_188X + off2_186X))) == (*((unsigned char *) key_168X)))) {
          goto L2029;}
        else {
          *((unsigned char *) (addr1_187X + u_182X)) = (unsigned char) ((*((unsigned char *) (addr2_188X + off2_186X))));
          goto L2029;}}
      else {
        if ((15 == bpp_169X)) {
          if (((*((unsigned char *) (addr2_188X + (((off2_186X)<<1))))) == (*((unsigned char *) key_168X)))) {
            if (((*((unsigned char *) (addr2_188X + (1 + (((off2_186X)<<1)))))) == (*((unsigned char *) (key_168X + 1))))) {
              goto L2029;}
            else {
              goto L2122;}}
          else {
            goto L2122;}}
        else {
          if ((16 == bpp_169X)) {
            if (((*((unsigned char *) (addr2_188X + (((off2_186X)<<1))))) == (*((unsigned char *) key_168X)))) {
              if (((*((unsigned char *) (addr2_188X + (1 + (((off2_186X)<<1)))))) == (*((unsigned char *) (key_168X + 1))))) {
                goto L2029;}
              else {
                goto L2110;}}
            else {
              goto L2110;}}
          else {
            if ((24 == bpp_169X)) {
              if (((*((unsigned char *) (addr2_188X + (3 * off2_186X)))) == (*((unsigned char *) key_168X)))) {
                if (((*((unsigned char *) (addr2_188X + (1 + (3 * off2_186X))))) == (*((unsigned char *) (key_168X + 1))))) {
                  if (((*((unsigned char *) (addr2_188X + (2 + (3 * off2_186X))))) == (*((unsigned char *) (key_168X + 2))))) {
                    goto L2029;}
                  else {
                    goto L2094;}}
                else {
                  goto L2094;}}
              else {
                goto L2094;}}
            else {
              if ((32 == bpp_169X)) {
                if (((*((unsigned char *) (addr2_188X + (((off2_186X)<<2))))) == (*((unsigned char *) key_168X)))) {
                  if (((*((unsigned char *) (addr2_188X + (1 + (((off2_186X)<<2)))))) == (*((unsigned char *) (key_168X + 1))))) {
                    if (((*((unsigned char *) (addr2_188X + (2 + (((off2_186X)<<2)))))) == (*((unsigned char *) (key_168X + 2))))) {
                      if (((*((unsigned char *) (addr2_188X + (3 + (((off2_186X)<<2)))))) == (*((unsigned char *) (key_168X + 3))))) {
                        goto L2029;}
                      else {
                        goto L2074;}}
                    else {
                      goto L2074;}}
                  else {
                    goto L2074;}}
                else {
                  goto L2074;}}
              else {
                goto L2029;}}}}}}
    else {
      goto L2029;}}
  else {
    arg1K0 = (j_180X + incy_179X);
    goto L1998;}}
 L2029: {
  arg1K0 = (i_181X + incx_178X);
  goto L2003;}
 L2122: {
  *((unsigned char *) (addr1_187X + (((u_182X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (((off2_186X)<<1))))));
  *((unsigned char *) (addr1_187X + (1 + (((u_182X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (1 + (((off2_186X)<<1)))))));
  goto L2029;}
 L2110: {
  *((unsigned char *) (addr1_187X + (((u_182X)<<1)))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (((off2_186X)<<1))))));
  *((unsigned char *) (addr1_187X + (1 + (((u_182X)<<1))))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (1 + (((off2_186X)<<1)))))));
  goto L2029;}
 L2094: {
  *((unsigned char *) (addr1_187X + (3 * u_182X))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (3 * off2_186X)))));
  *((unsigned char *) (addr1_187X + (1 + (3 * u_182X)))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (1 + (3 * off2_186X))))));
  *((unsigned char *) (addr1_187X + (2 + (3 * u_182X)))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (2 + (3 * off2_186X))))));
  goto L2029;}
 L2074: {
  *((unsigned char *) (addr1_187X + (((u_182X)<<2)))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (((off2_186X)<<2))))));
  *((unsigned char *) (addr1_187X + (1 + (((u_182X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (1 + (((off2_186X)<<2)))))));
  *((unsigned char *) (addr1_187X + (2 + (((u_182X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (2 + (((off2_186X)<<2)))))));
  *((unsigned char *) (addr1_187X + (3 + (((u_182X)<<2))))) = (unsigned char) ((*((unsigned char *) (addr2_188X + (3 + (((off2_186X)<<2)))))));
  goto L2029;}
}
void xform_clipB(double *mat_189X, double *inv_190X, struct rect *src_rect_191X, struct rect *dest_rect_192X, struct rect *scratch1_193X, struct rect *scratch2_194X)
{
  struct rect *r_213X;
  double y4_212X;
  double x4_211X;
  double y3_210X;
  double x3_209X;
  double y2_208X;
  double x2_207X;
  double y1_206X;
  double x1_205X;
  struct rect *r_204X;
  double y4_203X;
  double x4_202X;
  double y3_201X;
  double x3_200X;
  double y2_199X;
  double x2_198X;
  double y1_197X;
  double x1_196X;
  long v_195X;
 {  v_195X = mat_invert3x3(mat_189X, inv_190X);
  if ((0 == v_195X)) {
    scratch1_193X->left = (src_rect_191X->left);
    scratch1_193X->top = (src_rect_191X->top);
    scratch1_193X->right = (src_rect_191X->right);
    scratch1_193X->bottom = (src_rect_191X->bottom);
    x1_196X = xform_rect(mat_189X, src_rect_191X, &y1_197X, &x2_198X, &y2_199X, &x3_200X, &y3_201X, &x4_202X, &y4_203X, &r_204X);bound_quadB(x1_196X, y1_197X, x2_198X, y2_199X, x3_200X, y3_201X, x4_202X, y4_203X, r_204X);rect_intersectB(dest_rect_192X, src_rect_191X, scratch2_194X);
    x1_205X = xform_rect(inv_190X, scratch2_194X, &y1_206X, &x2_207X, &y2_208X, &x3_209X, &y3_210X, &x4_211X, &y4_212X, &r_213X);bound_quadB(x1_205X, y1_206X, x2_207X, y2_208X, x3_209X, y3_210X, x4_211X, y4_212X, r_213X);
    scratch2_194X->right = (1 + (scratch2_194X->right));
    scratch2_194X->bottom = (1 + (scratch2_194X->bottom));
    rect_intersectB(scratch1_193X, scratch2_194X, src_rect_191X);
    return;}
  else {
    return;}}
}

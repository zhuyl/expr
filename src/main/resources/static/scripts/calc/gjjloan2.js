function gjjloan2(obj)
{

  var gryjce;//ס������������½ɴ��
  var poyjce;//��żס������������½ɴ��
  var grjcbl;//�ɴ����
  var pojcbl;//��ż�ɴ����
  var xy; //��������
  var fwzj;//�����ܼ�
  var fwxz;//��������
  var dknx;//������������
  var syhk; //���»����

  var dked;//��Ҫ������
  var hkfs;//���ʽ
  var bxhj; //��Ϣ�ϼ�
  var bxhj2; //��Ϣ�ϼƵȱ���

//�м����
 var gbl;
 var jtysr; //��ͥ������
 var r;//�»���
 var rb;
 var gjjdka;//ס�������������a
 var gjjdkb;//ס�������������b
 var gjjdkc;//ס�������������c


 gryjce=obj.mount2.value;
if(gryjce<=0){
	alert('ס������������½ɴ���Ϊ��,������.');
         obj.mount2.value='';
         obj.mount.focus();
         return;
}

 poyjce=obj.mount3.value;
/*if (obj.jcbl[0].checked==true)
{grjcbl=0.08;}
else {grjcbl=0.1;}

if (obj.p_bl[0].checked==true){pojcbl=0.08;}
else {pojcbl=0.1;}
*/
grjcbl=obj.jcbl.value/100;
pojcbl=obj.p_bl.value/100;
if (obj.xz[0].checked==true){fwxz=0.9;}
else {fwxz=0.8;}

if (obj.xy[0].checked==true){xy=1.15;}
else if(obj.xy[1].checked==true){xy=1.3;}
else {xy=1;}



 fwzj=obj.mount.value;

if(fwzj<=0){alert('�����ܼ۲���Ϊ��,������');
                     obj.mount.value='';return;}

 dknx=Math.round(obj.mount10.value);
//alert(dknx);
if(dknx<=0){alert('�����������޲���Ϊ��,������');
                     obj.mount10.value='';return;}





var bcv=0;
                     if (dknx>5)
                     {
                      bcv=Math.round( 1000000 * l6_30/12 ) / 1000000;
                    }else{
                    	 bcv=Math.round( 1000000 * l1_5/12 ) / 1000000;
                    	}
r=adv_format((10000*bcv*Math.pow(1+bcv,12*dknx))/(Math.pow(1+bcv,12*dknx)-1),2);

jtysr=Math.ceil((gryjce/grjcbl+poyjce/pojcbl)*10)/10;
gjjdka=Math.min(Math.round((jtysr-400)/r*10000*10)/10,800000);
gjjdkb=Math.round(gjjdka*xy*10)/10;
gjjdkc=Math.round(fwzj*fwxz*10)/10;
//obj.ze2.value=gjjdka; //jtysr;
//obj.ze2.value=Math.floor(Math.min(gjjdkb,gjjdkc)/10000*10)/10;

//����2
zgdk=obj.ze2.value; //��ߴ�����

dked=Math.round(obj.need.value*10)/10;

obj.need.value=dked;

if(dked==0){alert('��Ҫ�Ĵ����Ȳ���Ϊ��,������');
                     obj.need.value='';return;}
if(dked<0){alert('����Ĵ����Ȳ�����Ҫ��,������');
                     obj.need.value='';return;}


if(dked>zgdk){alert('���ܸ�����ߴ�����,����������');
                     obj.need.value='';return;}


hkfs=obj.select.value;

if(hkfs==1){
//obj.ze22.value=Math.ceil(dked*r*100)/100;
//==============================modify by xujianfei
var ylv_new ;

if(dknx>=1&&dknx<=5)
ylv_new = l1_5/12;
else
ylv_new = l6_30/12;


var ncm  = parseFloat(ylv_new) + 1;//n����

var dknx_new = dknx*12;



total_ncm = Math.pow(ncm, dknx_new)

obj.ze22.value = Math.round(((dked*10000*ylv_new*total_ncm)/(total_ncm-1))*100)/100;
var pp = Math.round(((dked*10000*ylv_new*total_ncm)/(total_ncm-1))*100)/100;

//=========================================================
gbl=Math.round(Math.ceil(dked*r*100)/100/jtysr*1000)/10;
obj.yj2.value=gbl;
//bxhj=Math.round(r*dked*dknx*12*100)/100;
bxhj = Math.round(pp*dknx*12*100)/100;
obj.lx2.value=bxhj;
}
if (hkfs==2)
{
if (dknx>5)
{
	rb=l6_30*100;
	}else{
		rb=l1_5*100;
		}

syhk=Math.round((dked*10000/(dknx*12)+dked*10000*rb/(100*12))*100)/100;
obj.sfk2.value=syhk;
var yhke; //�»����
var bxhj; //��Ϣ�ϼ�
var dkys; //��������
var sydkze;//��ǰʣ������ܶ�
var yhkbj; //�»����
dkys=dknx*12;
yhkbj=dked*10000/dkys;

yhke=syhk;
sydkze=dked*10000-yhkbj;
bxhj=syhk;
for (var count=2;count<=dkys; ++count)
	{
       		//yhke=Math.round((dked*10000/(dknx*12)+sydkze*rb/(100*12))*100)/100;
		yhke=dked*10000/dkys+sydkze*rb/1200;
		sydkze-=yhkbj;
		bxhj+=yhke;
	}
obj.lx3.value= Math.round(bxhj*100)/100;
}

if (hkfs==3)
{

switch(dknx){//���ɻ���ʽ����ͻ������ձ�,�������ʲ��޸�
	case 1 :  rb=83.04/100; break;
	case 2 :  rb=81.08/100; break;
	case 3 :  rb=79.12/100; break;
	case 4 :  rb=77.16/100; break;
	case 5 :  rb=75.20/100; break;
	case 6 :  rb=73.24/100; break;
	case 7 :  rb=71.28/100; break;
	case 8 :  rb=69.32/100; break;
	case 9 :  rb=67.36/100; break;
	case 10 :  rb=65.40/100; break;
	case 11 :  rb=63.44/100; break;
	case 12 :  rb=61.48/100; break;
	case 13 :  rb=59.52/100; break;
	case 14 :  rb=57.56/100; break;
	case 15 :  rb=55.60/100; break;
	case 16 :  rb=53.64/100; break;
	case 17 :  rb=51.68/100; break;
	case 18 :  rb=49.72/100; break;
	case 19 :  rb=47.76/100; break;
	case 20 :  rb=45.80/100; break;
	case 21 :  rb=43.84/100; break;
	case 22 :  rb=41.88/100; break;
	case 23 :  rb=39.92/100; break;
	case 24 :  rb=37.96/100; break;
	case 25 :  rb=36.00/100; break;
	case 26 :  rb=34.04/100; break;
	case 27 :  rb=32.08/100; break;
	case 28 :  rb=30.12/100; break;
	case 29 :  rb=28.16/100; break;
	case 30 :  rb=26.20/100; break;
}
var yhke; //�»����
var ll;//����
var zhbj;//���һ�ڱ���
zhbj = Math.round(dked*10000*rb*100)/100;
if (dknx<=5)
{
	ll=l1_5/12;
	zdhkll=0.0351/12;
	var total_gjj = Math.pow(zdhkll + 1, dknx*12);
	syhk=Math.ceil(dked*10000*zdhkll*total_gjj/(total_gjj-1));
}
else
{
	ll=l6_30/12;
	zdhkll=0.0423/12;
	var total_gjj = Math.pow(zdhkll + 1, dknx*12-1);
	syhk=Math.ceil((dked*10000-zhbj)*zdhkll*total_gjj/(total_gjj-1)+zhbj*zdhkll);
}
	obj.sfk3.value=syhk;       //��ͻ����
	var zhyqbj=dked*10000;
	var zchlx=0;//�ܳ�����Ϣ
	for (i=1;i<dknx*12 ;i++ )
	{
		zchlx+=Math.round(zhyqbj*ll*100)/100;
		zhyqbj=Math.round((zhyqbj-(syhk-Math.round(zhyqbj*ll*100)/100))*100)/100;
	}
	var sydkze=dked*10000-syhk;
	obj.lx4.value=zhyqbj;    //����ڱ���
	obj.lx5.value=Math.round(zhyqbj*ll*100)/100;
	/*for (i=1;i<dknx*12 ;i++ )
	{
		zchlx+=Math.round((dked*10000-(syhk-Math.round(dked*10000*ll*100)/100))*ll*100)/100;
	}*/
	zchlx+=Math.round(zhyqbj*ll*100)/100;
	obj.lx6.value=Math.round(zchlx*100)/100;
}


//�����������ߴ�����
/*
˵��
��ͥ�����룽ס������������½ɴ��½ɴ����+��żס������������½ɴ��½ɴ����

ס�������������a������ͥ�����룭400���µȶ�����»����ÿ��Ԫ�»����Ҳ�����40��Ԫ

���ڸ������õȼ�ΪAAA�ģ�ס�������������b��ס�������������a��130��

���ڸ������õȼ�ΪAA�ģ�ס�������������b��ס�������������a��115��

���ڸ������õȼ������ģ�ס�������������b��ס�������������a

�Է�������Ϊ��Ʒ���ڷ��ģ�ס�������������c�������ܼۡ�90��

�Է�������Ϊ�����ģ�ס�������������c�������ܼۡ�95��

��ߴ�����d��min��b��c��

�ȶ�������ʽ��

�ȶ�𻹿ʽ

���»����=P/��n��12��+����ܶ��I

���У�PΪ�����IΪ�����ʣ�nΪ�������ޡ� */
}

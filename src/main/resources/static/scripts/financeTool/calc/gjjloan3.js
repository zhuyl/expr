function gjjloan3(obj)
{
var dkye=0;//����Ҫ���������
var dkzqs=0;//����������
var gdhke=0;//�̶������
var sxhke=0;//���軹���
var sxhky=0; //����Ҫ�Ļ�������
var zhhke=0;//��󻹿��
var zglx=0;//�ܹ���Ϣ
var dylx=0 ; //������Ϣ
var syqs=0;
syqs=Number(obj.lx8_sy.value);
dkye=Number(obj.lx7.value);
if(dkye<=0 || dkye >780000 || isNaN(dkye) )
{
	alert("����������벻��ȷ");
	return;
}
var ll;   //������
if(obj.lx8[1].checked)
{ll=Math.round( 1000000 * l6_30/12 ) / 1000000;}
else
{ll=Math.round( 1000000 * l1_5/12 ) / 1000000;}
/*if(dkzqs<=0 || dkzqs>360 || isNaN(dkzqs))
{
	alert("��������������ȷ!");
	return;
}*/

gdhke=Number(obj.lx9.value);
if( Number(syqs) <= 0  || isNaN(syqs))
{
	alert("��������ȷ��ʣ������!");
	return;
}
if( Number(gdhke) <= 0  || isNaN(gdhke))
{
	alert("��������ȷ�Ĺ̶������!");
	return;
}

var first_lx=Math.round( dkye * ll *100 ) /100 ;
if (first_lx > gdhke)
{alert('�̶������������������Ϣ '+first_lx);obj.lx9.focus();obj.lx9.select();return;}
var yjqs=0;//Math.ceil(dkye/gdhke);
var sxhky=0;
for(var i=1;i<syqs;i++){
     //��Ҫ������+1
     sxhky =sxhky + 1;
     //����һ���µ���Ϣ
     dylx = Math.round( dkye * ll *100 ) /100 ;
     //�ۼ���Ϣ
     zglx = zglx+dylx;
//Math.round ((zglx + dylx) *100) /100 ;

      if (dkye + dylx >= gdhke  )
       {
		  if(dkye + dylx == gdhke)zhhke= dkye +  dylx;
          dkye = Math.round((dkye-( gdhke - dylx ))*100)/100;
//Math.round(  (dkye - ( gdhke - dylx ))*100  ) /100;
       }
      else
       {
	   zhhke= dkye +  dylx;
	   dkye=-1;
        break;
       }

}
if(dkye>0){
	sxhky =sxhky + 1;
	dylx = Math.round( dkye * ll *100 ) /100 ;
	zglx = zglx+dylx;
	zhhke= dkye +  dylx
}


if (sxhky > syqs)
   {
      alert("���벻��ȷ,�����º˶Դ��������¹̶������!"+sxhky);
      return;
   }



    obj.lx10.value=sxhky ;
    obj.lx11.value=Format(zhhke,2);
    obj.lx12.value=Format(zglx,2) ;
      //���ʣ�౾��+��Ϣ< �̶�������   ==> �������  ->����ڻ����

}
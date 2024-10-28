package edu.jmu.sudi.utils;

import java.util.Arrays;
public class Combination{

	private int[] index;//���ڴ洢��Ҫ��ϵ�������±�ĳ�Ա������
	private int length;//��ʾ���������ĳ��ȡ�
	private int n;//������е�Ԫ�ظ���
	private long numLeft;//���ڴ洢ʣ��������и����ĳ�Ա������
	private long total;//���ڴ洢������������ĳ�Ա������
	
	public Combination(int length){
		this(length,0);
	}
	
	public Combination(int length,int n){		
		this.length=length;
		this.n=n;
		reset();
	}
	
	public void reset(){
		
		if(n>length){
			System.out.println("需要组合的个数超出数组元素个数！");
			System.exit(1);
		}
		
		//��ʼ��numLeft����ʼʱnumLeftӦ��Ϊ2^n.
		total=numLeft=(int)Math.pow((double)2,(double)length);

		//��ʼ������index��
		index=new int[length];
		Arrays.fill(index,0);
	}
	
	private int sum(){
		int s=0;
		for(int i:index){
			s+=i;
		}
		return s;
	}
	
	public boolean hasMore(){
		return numLeft > 0;
	}
	
	public int[] getNext(){

		index[0]+=1;
		for(int i=0;i<index.length;i++){
			if(index[i]==2){
				index[i]=0;
				if(i!=index.length-1){
					index[i+1]+=1;
				}
			}
		}
		numLeft--;		
		if(this.n!=0){
			if(sum()==this.n){
				return index;
			}else if(hasMore()) {
				return getNext();
			}
		}
		return index;
	}
}
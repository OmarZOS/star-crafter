#include "Header.h"


int main()
{
OMatrix M(2,2),N(2,2),K,V;

cin>>M;
cin>>N;
		
		/*K.M[0][0].fl.enfiler(5);
		K.M[0][0].fl.enfiler(5);
		K.M[0][0].fl.enfiler(5);
		K.M[0][0].fl.enfiler(5);
		K.M[0][0].fl.enfiler(5);
		cout<<K.M[0][0].fl.defiler();
		cout<<K.M[0][0].fl.defiler();
		cout<<K.M[0][0].fl.defiler();
		cout<<K.M[0][0].fl.defiler();
		cout<<K.M[0][0].fl.defiler();*/
cout<< M<<endl;
cout<< N<<endl;
auto start=chrono::steady_clock::now();
K=M*N;
K.Cleaner();
auto end=chrono::steady_clock::now();
cout<<"Omar's multiplication calculated in "<<chrono::duration_cast<chrono::nanoseconds>(end-start).count()<<" nanoseconds"<<endl;
cout<<K<<endl;

auto strt=chrono::steady_clock::now();
V=M/N;
auto nd=chrono::steady_clock::now();
cout<<"Simple multiplication calculated in "<<chrono::duration_cast<chrono::nanoseconds>(nd-strt).count()<<" nanoseconds"<<endl;





// I did this to verify if there is still any stuck numbers..

cout<<V<<endl;


	


cout<<"I guess I'm no longer motivated to develop this..\nThe Cells probably require CritSects to prevent threads from colliding..\nIt was nice to think about the whole project but it's 100 times slower than the simple way for a 2x2 Matrix so far..\nSo.. Thank you anyway.."<<endl;


return 0;
}





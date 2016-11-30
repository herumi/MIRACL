CFLAGS=-c -Ofast -I./include
LIB_SRC=mrcore.c mrarth0.c mrarth1.c mrarth2.c mralloc.c mrsmall.c mrio1.c mrio2.c mrgcd.c mrjack.c mrxgcd.c mrarth3.c mrbits.c mrrand.c mrprime.c mrcrt.c mrscrt.c mrmonty.c mrpower.c mrsroot.c mrcurve.c mrfast.c mrshs.c mrshs256.c mrshs512.c mrsha3.c mrfpe.c mraes.c mrgcm.c mrlucas.c mrzzn2.c mrzzn2b.c mrzzn3.c mrzzn4.c mrecn2.c mrstrong.c mrbrick.c mrebrick.c mrec2m.c mrgf2m.c mrflash.c mrfrnd.c mrdouble.c mrround.c mrbuild.c mrflsh1.c mrpi.c mrflsh2.c mrflsh3.c mrflsh4.c

LIB_OBJ=$(LIB_SRC:.c=.o) mrmuldv.o
VPATH=source source/curve source/curve/pairing

all: main

mrmuldv.o: mrmuldv.g64
	gcc -x c $(CFLAGS) $<
%.o: %.c
	gcc $(CFLAGS) $<
%.o: %.cpp
	g++ $(CFLAGS) $<

miracl.a: $(LIB_OBJ)
	ar r $@ $(LIB_OBJ)

PAIRING_SRC=ake12bnx.cpp zzn12a.cpp zzn4.cpp ecn2.cpp zzn2.cpp big.cpp zzn.cpp ecn.cpp
PAIRING_OBJ=$(PAIRING_SRC:.cpp=.o)

main: miracl.a $(PAIRING_OBJ)
	g++ -o main $(PAIRING_OBJ) miracl.a

clean:
	rm -rf *.o main

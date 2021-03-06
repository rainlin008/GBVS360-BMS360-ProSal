CC = clang++
CFLAGS = -W -Wall -g  \
			 -I/usr/local/opt/opencv3/include \
			 -I/usr/local/opt/boost/include \
			 -I/usr/local/opt/fftw/include \
			 -Ilib/libgnomonic/src -Ilib/libgnomonic/lib/libinter/src \
			 -Ilib/libbms/src \
			 -Ilib/libgbvs/src \
			 -Ilib/libhmd/src \
			 -Ilib/liblinper/src \
			 -Ilib/libmeanshift/src \
			 -Ilibgbvs360 

LDFLAGS = -L/usr/local/opt/boost/lib \
		  -L/usr/local/opt/opencv3/lib \
		  -L/usr/local/opt/fftw/lib \
		  -I/usr/local/opt/fftw/include \
		  -Llib/libgnomonic/bin -Llib/libgnomonic/lib/libinter/bin \
		  -Llib/libbms/bin \
		  -Llib/libgbvs/bin \
		  -Llib/liblinper/bin \
		  -Llib/libhmd/bin \
		  -Llib/libmeanshift/bin \
		  -lopencv_core -lopencv_imgproc -lopencv_objdetect -lopencv_highgui -lopencv_imgcodecs -lopencv_videoio \
		  -lboost_program_options -lboost_exception -lboost_thread-mt -lboost_system -lboost_regex-mt \
		  -lgnomonic -linter \
		  -lbms \
		  -lgbvs \
		  -lfftw3 \
		  -llinper \
		  -lmean_shift \
		  -lhmd


SRC = $(wildcard libgbvs360/*.cpp libgbvs360/*.cc Salient360/*.cpp Salient360/*.c Salient360/*.cc)
OBJS = $(SRC:.cpp=.o)
AOUT = bin/salient

TESTS_SRC = $(wildcard bms/main-saliency.cpp)
TESTS_OBJS = $(TESTS_SRC:.cpp=.o)
TESTS = bin/bms

PRIOR_SRC = $(wildcard test/main-prior.cpp)
PRIOR_OBJS = $(PRIOR_SRC:.cpp=.o)
PRIOR = bin/apply_prior

ANALYSIS_SRC = $(wildcard test/analysis.cpp)
ANALYSIS_OBJS = $(ANALYSIS_SRC:.cpp=.o)
ANALYSIS = bin/analysis

FEATURE_SRC = $(wildcard test/feature-test.cpp)
FEATURE_OBJS = $(FEATURE_SRC:.cpp=.o)
FEATURE = bin/feature

all : $(AOUT) $(PRIOR) $(TESTS)
tests: $(TESTS)
analysis: $(ANALYSIS)
prior: $(PRIOR)
feature: $(FEATURE)

bin/salient : $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^
%.o : %.cpp
	$(CC) $(CFLAGS) -o $@ -c $<
clean :
	@rm Salient360/*.o libgbvs360/*.o 
cleaner : clean
	@rm $(AOUT)


bin/bms : $(TESTS_OBJS)
	$(CC) $(LDFLAGS) -o $@ $^


bin/analysis : $(ANALYSIS_OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

bin/apply_prior : $(PRIOR_OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

bin/feature : $(FEATURE_OBJS)
	$(CC) $(LDFLAGS) -o $@ $^
	
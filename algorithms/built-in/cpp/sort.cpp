#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <format>
#include <fstream>
#include <getopt.h>
#include <iostream>
using namespace std;

typedef struct t_opts {
  int lower, upper, steps, iter;
  string outfile = "";
} t_opts;

t_opts *parse_opts(int argc, char *argv[]);
int *create_array(int n);
long time_sort(int *data, int n, int iter);
string format_time(long elapsed, int n, bool isOutFile);

int main(int argc, char *argv[]) {
  ofstream outStream;
  ofstream file;
  ostream *out = &cout;
  t_opts *opts = parse_opts(argc, argv);

  if (argc < 8) {
    cerr << "usage: " << argv[0]
         << " -l [lower] -u [upper] -s [steps] -i [iter] (-o outfile)"
         << "\n";
    return 1;
  }

  if (!opts->outfile.empty()) {
    file.open(opts->outfile);
    if (!file) {
      cerr << "Failed to open file\n";
      return 1;
    }
    out = &file;
  }

  srand(time({}));
  for (int n = opts->lower; n <= opts->upper; n += opts->steps) {
    auto data = create_array(n);
    auto elapsed = time_sort(data, n, opts->iter);
    free(data);

    elapsed = elapsed / opts->iter;
    auto outText = format_time(elapsed, n, !opts->outfile.empty());
    *out << outText << "\n";
  }

  delete opts;
  return 0;
}

t_opts *parse_opts(int argc, char *argv[]) {
  int opt;
  t_opts *opts = new t_opts;

  while ((opt = getopt(argc, argv, "l:u:s:i:o:")) != -1) {
    switch (opt) {
      case 'l':
        opts->lower = atoi(optarg);
        break;
      case 'u':
        opts->upper = atoi(optarg);
        break;
      case 's':
        opts->steps = atoi(optarg);
        break;
      case 'i':
        opts->iter = atoi(optarg);
        break;
      case 'o':
        opts->outfile = optarg;
        break;
    }
  }

  return opts;
}

int *create_array(int n) {
  int *data = (int *)calloc(n, sizeof(int));

  for (int i = 0; i < n; i++) {
    data[i] = rand();
  }

  return data;
}

long time_sort(int *data, int n, int iter) {
  int *tmp = (int *)calloc(n, sizeof(int));
  copy(data, data + n, tmp);

  auto start = std::chrono::high_resolution_clock::now();

  for (int i = 0; i < iter; i++) {
    memcpy(data, tmp, n * sizeof(tmp[0]));
    sort(data, data + n);
  }

  auto finish = std::chrono::high_resolution_clock::now();
  auto duration =
      std::chrono::duration_cast<std::chrono::nanoseconds>(finish - start)
          .count();

  free(tmp);
  return duration;
}

string format_time(long elapsed, int n, bool isOutFile) {
  string out;

  if (isOutFile) {
    out = format("{}, {}", n, elapsed);
  } else {
    out = format("{}:\t{}ns", n, elapsed);
  }

  return out;
}

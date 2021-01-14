#include <sys/stat.h>
#include <limits.h>

typedef struct {
	char fn[PATH_MAX];
	int fd;
	int is_dir;
	int file_count;
	mode_t mode;
	ino_t ino;
} WatchFile;

extern WatchFile **files;

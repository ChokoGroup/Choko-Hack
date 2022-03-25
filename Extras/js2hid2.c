#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/input.h>

int main() {
  int joy_fd0;
  int joy_fd1;
  if ( ( joy_fd0 = open( "/dev/input/event2" , O_RDONLY|O_NONBLOCK)) == -1 ) {
    printf("Could not open /dev/input/event2\n");
    return -1;
  }
  if ( ( joy_fd1 = open( "/dev/input/event3" , O_RDONLY|O_NONBLOCK)) == -1 ) {
    printf("Could not open /dev/input/event3\n");
    return -1;
  }

  FILE * hid_fd0;
  FILE * hid_fd1;
  if ((access("/dev/hidg0", W_OK) == 0) && ((hid_fd0 = fopen("/dev/hidg0", "a")) == NULL)) {
    printf("Could not open /dev/hidg0\n");
    return -1;
  }
  if ((access("/dev/hidg1", W_OK) == 0) && ((hid_fd1 = fopen("/dev/hidg1", "a")) == NULL)) {
    printf("Could not open /dev/hidg1\n");
    return -1;
  }

  struct input_event event;
  char *axis0 = (char *) calloc( 2, sizeof( char ) );
  char *axis1 = (char *) calloc( 2, sizeof( char ) );
  axis0[0] = 127; axis0[1] = 127;
  axis1[0] = 127; axis1[1] = 127;
  unsigned char buttons0 = 0;
  unsigned char buttons1 = 0;
  while (1) {
    if (read(joy_fd0, &event, sizeof(struct input_event)) > 0) {
      switch (event.type) {
/*
        Event type 3 (EV_ABS)
        Event code 1 (ABS_Y)
        Event code 0 (ABS_X)
              value    127
              Min        0
              Max      255
              Flat      15
*/
        case 3:
          axis0[event.code] = event.value;
        break;
/*
        Event type 1 (EV_KEY)
        Event code 288 (BTN_TRIGGER)
        Event code 289 (BTN_THUMB)
        Event code 290 (BTN_THUMB2)
        Event code 291 (BTN_TOP)
        Event code 292 (BTN_TOP2)
        Event code 293 (BTN_PINKIE)
        Event code 294 (BTN_BASE)
        Event code 295 (BTN_BASE2)
              value   0 or 1
*/
        case 1:
          if (event.value == 1) {
            buttons0 = buttons0 | (1 << (event.code % 8));
          } else {
            buttons0 = buttons0 & ~(1 << (event.code % 8));
          }

        break;
      }
      if (axis0[0] == 0) {           /* X = left */
        fputc(0x81, hid_fd0);
      } else if (axis0[0] == 255) {  /* X = right */
        fputc(0x7F, hid_fd0);
      } else {                      /* X = center */
        fputc(0x00, hid_fd0);
      }
      if (axis0[1] == 0) {           /* X = up */
        fputc(0x81, hid_fd0);
      } else if (axis0[1] == 255) {  /* X = down */
        fputc(0x7F, hid_fd0);
      } else {                      /* X = center */
        fputc(0x00, hid_fd0);
      }
      fputc(buttons0, hid_fd0);
      fflush(hid_fd0);
    }
    if (read(joy_fd1, &event, sizeof(struct input_event)) > 0) {
      switch (event.type) {
/*
        Event type 3 (EV_ABS)
        Event code 1 (ABS_Y)
        Event code 0 (ABS_X)
              value    127
              Min        0
              Max      255
              Flat      15
*/
        case 3:
          axis1[event.code] = event.value;
        break;
/*
        Event type 1 (EV_KEY)
        Event code 288 (BTN_TRIGGER)
        Event code 289 (BTN_THUMB)
        Event code 290 (BTN_THUMB2)
        Event code 291 (BTN_TOP)
        Event code 292 (BTN_TOP2)
        Event code 293 (BTN_PINKIE)
        Event code 294 (BTN_BASE)
        Event code 295 (BTN_BASE2)
              value   0 or 1
*/
        case 1:
          if (event.value == 1) {
            buttons1 = buttons1 | (1 << (event.code % 8));
          } else {
            buttons1 = buttons1 & ~(1 << (event.code % 8));
          }

        break;
      }
      if (axis1[0] == 0) {           /* X = left */
        fputc(0x81, hid_fd1);
      } else if (axis1[0] == 255) {  /* X = right */
        fputc(0x7F, hid_fd1);
      } else {                      /* X = center */
        fputc(0x00, hid_fd1);
      }
      if (axis1[1] == 0) {           /* X = up */
        fputc(0x81, hid_fd1);
      } else if (axis1[1] == 255) {  /* X = down */
        fputc(0x7F, hid_fd1);
      } else {                      /* X = center */
        fputc(0x00, hid_fd1);
      }
      fputc(buttons1, hid_fd1);
      fflush(hid_fd1);
    }
  }
  /* this will never happen */
  fclose( hid_fd0 );
  fclose( hid_fd1 );
  close( joy_fd0 );
  close( joy_fd1 );
	return 0;
}


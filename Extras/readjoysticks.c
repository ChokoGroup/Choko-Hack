#include <string.h>
#include <fcntl.h>
#include <linux/input.h>
#include <poll.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <unistd.h>

/*
  With -b option returns a string with 0's or 1's for each button;
  Without -b option returns:
      U = joystick up
      D = joystick down
      L = joystick left
      R = joystick right
      0..7 = what button was pressed
*/


int main(int argc, char **argv) {

  if (argc < 2) {
    printf("\n%s reads input from one or both joysticks with 1 sec timeout\nUsage: %s jN [jN] [-b]\njN: can be j1 or j2\n-b: read buttons state and exit; returns a string of 0's and 1's\n\n", argv[0], argv[0]);
    return -1;
  }

  int get_buttons_states = 0;
  int j1 = -1;
  int j2 = -1;

  for (int i = 1; i < argc; i++) {
    if ( ! strcmp(argv[i], "j1")) {
      j1 = open("/dev/input/event2", O_RDONLY|O_NONBLOCK);
    } else if ( ! strcmp(argv[i], "j2")) {
      j2 = open("/dev/input/event3", O_RDONLY|O_NONBLOCK);
    } else if ( ! strcmp(argv[i], "-b")) {
      get_buttons_states = 1;
    } else {
      printf("\nInvalid parameter found: %s\n%s reads input from one or both joysticks with 1 sec timeout\nUsage: %s jN [jN] [-b]\njN: can be j1 or j2\n-b: read buttons state and exit; returns a string of 0's and 1's\n\n", argv[i], argv[0], argv[0]);
      return -1;
    }
  }

  if (get_buttons_states) {
    unsigned char key_states[KEY_MAX/8 + 1];
    memset(key_states, 0, sizeof(key_states));
    if ((j1 < 0) && (j2 < 0)) {
      printf("\n%s reads input from one or both joysticks with 1 sec timeout\nUsage: %s jN [jN] [-b]\njN: can be j1 or j2\n-b: read buttons state and exit; returns a string of 0's and 1's\n\n", argv[0], argv[0]);
    }
    if (j1 > -1) {
      ioctl(j1, EVIOCGKEY(sizeof(key_states)), key_states);
      for (int i = 288; i < 296; i++) {
        printf("%d", (key_states[i / 8] >> (i % 8)) & 1);
      }
    }
    if (j2 > -1) {
      ioctl(j2, EVIOCGKEY(sizeof(key_states)), key_states);
      for (int i = 288; i < 296; i++) {
        printf("%d", (key_states[i / 8] >> (i % 8)) & 1);
      }
    }
  } else {

    int numberofjoy = 0;
    struct pollfd fds[2];

    if (j1 > -1) {
      fds[numberofjoy].fd = j1;
      fds[numberofjoy].events = POLLIN;
      numberofjoy++;
    }
    if (j2 > -1) {
      fds[numberofjoy].fd = j2;
      fds[numberofjoy].events = POLLIN;
      numberofjoy++;
    }

    // Read joysticks events, with 1000 ms timeout
    while (poll(fds, numberofjoy, 1000) > 0) {
      for (int i = 0; i < numberofjoy; i++) {
        if (fds[i].revents) {

          struct input_event event;
          if (read(fds[i].fd, &event, sizeof(struct input_event)) > 0) {
            switch (event.type) {
              case 3:
                if ((event.value == 0) && (event.code == 0)) {
                  printf("L");
                  return 0;
                }
                if ((event.value == 255) && (event.code == 0)) {
                  printf("R");
                  return 0;
                }
                if ((event.value == 0) && (event.code == 1)) {
                  printf("U");
                  return 0;
                }
                if ((event.value == 255) && (event.code == 1)) {
                  printf("D");
                  return 0;
                }
              break;
              case 1:
                if (event.value == 1) {
                  printf("%d", event.code % 8);
                  return 0;
                }
              break;
            }
          }
        }
      }
    }
  }
  return 0;
}

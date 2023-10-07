  .global main

  .data
usage: .string "./sum_arr N"
scanfmt: .string "%ld"
outfmt: .string "sum = %ld\n"

  .text
// long sum_arr(long *xs, long n) {
//   long y = 0;
//   for (long i = 0; i < n; i++) {
//       y += xs[i];
//   }

//   return y;

// xs %rdi
// n %rsi
// y %rax
sum_arr:
  enter $0, $0

  // int y = 0
  mov $0, %rax
  mov $0, %rcx
loop_cond:

  // if i >= n done
  cmp %rcx, %rsi
  jge loop_done

  // y += xs[i]
  add (%rdi, %rcx, 8), %rax

  // xs++
  inc %rdi
  // i++
  inc %rcx
  jmp loop_cond

loop_done:
  leave
  ret

main:
  push %r12
  push %r13
  push %r14
  enter $0, $0

  cmp $2, %rdi
  mov $usage, %rdi
  call puts
  mov $1, %rax
  jmp main_done

  call atol
  // long *xs = malloc(n * sizeof(long));

  mov %rax, %r8
  mov $1, %r9

loop_cond:
  cmp $r8, $r9
  jge loop_done

  mov $scanfmt, %rdi
  lea (%rsi), %r10
  call scanf

  cmp $1, %rax
  jne err_end

  jmp loop_cond

loop_done:
  // printf("sum = %ld\n", sum_arr(xs, n));

  // free(xs);


err_end:

  mov $1, %rax
main_done:
  leave
  pop %r14
  pop %r13
  pop %r12
  ret


/*
long sum_arr(long *xs, long n) {
  long y = 0;
  for (long i = 0; i < n; i++) {
      y += xs[i];
  }

  return y;
}

int main(int argc, char **argv) {
  if (argc != 2) {
    puts("nope");
    return 1;
  }

  long n = atol(argv[1]);
  long *xs = malloc(n * sizeof(long));

  for (long i = 0; i < n; i++) {
    int count = scanf("%ld", &(xs[i]));
    if (count != 1) abort()
  }

  printf("sum = %ld\n", sum_arr(xs, n));

  free(xs);

  return 0;
}
*/

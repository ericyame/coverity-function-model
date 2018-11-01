void foo_lock(void **l) {
    __coverity_exclusive_lock_acquire__(*l);
}

void foo_unlock(void **l) {
    __coverity_exclusive_lock_release__(*l);
}
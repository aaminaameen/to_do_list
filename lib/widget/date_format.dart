extension DateFormat on DateTime {
  String toShortDateString() {
    return '${this.day}/${this.month}/${this.year}';
  }
}

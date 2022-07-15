import 'package:flutter/material.dart';
import 'package:quotex/internal/pages/workspace.dart';

void pop(BuildContext context) => Navigator.of(context).pop();

/// Переход на главную страницу.
void replaceWithWorkspace(BuildContext context) => Navigator.of(context).pushReplacementNamed(Workspace.routeName);

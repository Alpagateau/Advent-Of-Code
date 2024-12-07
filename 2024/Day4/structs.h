#pragma once

typedef struct pos_t 
{
  int x;
  int y;
  void* next;
}pos_t;

pos_t *new(int x, int y)
{
  pos_t* n = (pos_t*)malloc(sizeof(pos_t));
  n->x = x;
  n->y = y;
  n->next = NULL;
  return n;
}

int push(pos_t *parent, pos_t *child)
{
  if(parent == NULL)
  {
    *parent = *child;
    printf("new list\n");
    return 0;
  }
  if(parent->next != NULL)
  {
    return push((pos_t*)parent->next, child);
  }
  else 
  {
    parent->next = child;
    return 0;
  }
}

pos_t *atIdx(pos_t *list, int idx)
{
  if(idx == 0)
  {
    return list;
  }else{
    if(list->next == NULL)
      return NULL;
    return atIdx(list->next, idx-1);
  }
}

int p_length(pos_t *list)
{
  if(list == NULL)
  {
    return 0;
  }
  else 
  {
    return 1 + p_length((pos_t*)list->next);
  }
}

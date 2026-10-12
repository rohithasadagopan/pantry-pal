CREATE TABLE public.pantry_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  ingredient text NOT NULL CHECK (char_length(ingredient) BETWEEN 1 AND 120),
  quantity numeric(10,2) NOT NULL DEFAULT 1 CHECK (quantity > 0),
  unit text NOT NULL DEFAULT 'item' CHECK (char_length(unit) BETWEEN 1 AND 40),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, ingredient)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pantry_items TO authenticated;
GRANT ALL ON public.pantry_items TO service_role;
ALTER TABLE public.pantry_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage their pantry" ON public.pantry_items FOR ALL TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE TABLE public.user_preferences (
  user_id uuid PRIMARY KEY,
  servings integer NOT NULL DEFAULT 4 CHECK (servings BETWEEN 1 AND 16),
  weekly_budget numeric(10,2) NOT NULL DEFAULT 80 CHECK (weekly_budget >= 0),
  dietary_tags text[] NOT NULL DEFAULT '{}',
  busy_nights text[] NOT NULL DEFAULT '{}',
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.user_preferences TO authenticated;
GRANT ALL ON public.user_preferences TO service_role;
ALTER TABLE public.user_preferences ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage their preferences" ON public.user_preferences FOR ALL TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE TABLE public.meal_plans (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  week_start date NOT NULL,
  dinners jsonb NOT NULL DEFAULT '[]'::jsonb,
  estimated_total numeric(10,2) NOT NULL DEFAULT 0 CHECK (estimated_total >= 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, week_start)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.meal_plans TO authenticated;
GRANT ALL ON public.meal_plans TO service_role;
ALTER TABLE public.meal_plans ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage their meal plans" ON public.meal_plans FOR ALL TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE TABLE public.grocery_carts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  plan_id uuid REFERENCES public.meal_plans(id) ON DELETE SET NULL,
  items jsonb NOT NULL DEFAULT '[]'::jsonb,
  estimated_total numeric(10,2) NOT NULL DEFAULT 0 CHECK (estimated_total >= 0),
  status text NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'confirmed')),
  confirmed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.grocery_carts TO authenticated;
GRANT ALL ON public.grocery_carts TO service_role;
ALTER TABLE public.grocery_carts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage their grocery carts" ON public.grocery_carts FOR ALL TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE TABLE public.meal_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  meal_name text NOT NULL CHECK (char_length(meal_name) BETWEEN 1 AND 160),
  cooked_on date NOT NULL DEFAULT CURRENT_DATE,
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.meal_history TO authenticated;
GRANT ALL ON public.meal_history TO service_role;
ALTER TABLE public.meal_history ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage their meal history" ON public.meal_history FOR ALL TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
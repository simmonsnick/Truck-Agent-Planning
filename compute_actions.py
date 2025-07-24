import sys
from collections import defaultdict

# ==== Plan File Input ====
plan_file = sys.argv[1] if len(sys.argv) > 1 else "sas_plan"

try:
    with open(plan_file, "r") as f:  # read each line of the plan file
        lines = f.readlines()
except FileNotFoundError:
    print(f"Error: Cannot open plan file: {plan_file}")
    sys.exit(1)

# === Count the number of real plan actions ===
num_actions = sum(
    1 for line in lines
    if line.strip() and not line.strip().startswith(";")
)


# === Calculate score based on number of actions ===
score = round(1.0 / (1 + num_actions), 3)
print("Action-Based:", score)


# === Base Segment Probabilities ===
base_segments = [
    ['M1', 'M2', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M1', 'M3', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
    ['M2', 'M3', 0.7, 0.7, 0.6, 0.6, 0.5, 0.5, 0.8],
    ['M2', 'M4', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M3', 'M4', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
    ['M3', 'M5', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M4', 'M5', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
    ['M5', 'M6', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M6', 'M7', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
]

# === Calculate segment possibility score ===
def calculate_possibility(probabilities):
    return min(
        probabilities[0],
        probabilities[1],
        1 - probabilities[2],
        1 - probabilities[3],
        1 - probabilities[4],
        1 - probabilities[5]
    )

# === Get path score ===
def calculate_path_possibility(path, possibilities):
    try:
        return min(possibilities[(path[i], path[i + 1])] for i in range(len(path) - 1))
    except KeyError:
        return None


def truck_plan_path(plan_lines):
    path = []
    for line in plan_lines:
        line_lower = line.lower()
        if "drive" in line_lower and "truck" in line_lower:
            parts = line.strip("()\n").split()
            if len(parts) >= 4:
                from_loc = parts[2].upper()
                to_loc = parts[3].upper()
                if not path:
                    path.append(from_loc)
                path.append(to_loc)
    return path

# === Main Function ===
def main():

    # === Actual Plan Analysis ===
    try:
        with open(plan_file, "r") as f:
            plan_lines = f.readlines()
    except FileNotFoundError:
        print(f"\nError: Cannot open plan file: {plan_file}")
        return

    actual_path = truck_plan_path(plan_lines)

    if actual_path:
        # Build possibility map
        base_possibility = {
            (row[0], row[1]): calculate_possibility(row[2:])
            for row in base_segments
        }
        actual_poss = calculate_path_possibility(actual_path, base_possibility)
        real_path_str = '-'.join(actual_path)
        print(f"\nActual Plan Path: {real_path_str}")
        #print(f"Actual Path Possibility: {round(actual_poss, 3)}")
    else:
        print("\nNo drive-truck actions found in plan.")


if __name__ == "__main__":
    main()
